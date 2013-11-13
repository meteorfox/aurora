package aurora

import com.paypal.aurora.MeteringService
import com.paypal.aurora.OpenStackRESTService
import com.paypal.aurora.TimeUtils
import com.paypal.aurora.model.SessionStorage
import grails.test.mixin.TestFor
import org.gmock.GMockTestCase
import org.gmock.WithGMock
import org.joda.time.DateTime
import org.joda.time.DateTimeZone
import org.junit.Before

@WithGMock
@TestFor(MeteringService)
class MeteringServiceTest extends GMockTestCase {

    private static final METERING = 'metering'
    private static final int INTERVAL = 3600
    private static final int COUNT = 5
    private static final String TYPE = 'instance:m1.tiny'
    private static final TENANT = [id: "123"]
    private static final METERS = [
            "meters": [
                    [
                            "unit": "ns",
                            "resource_id": "29f55366-a66f-4043-972e-ef87854063dd",
                            "source": "openstack",
                            "project_id": "5a876fb5d94d4220b5c8afb228647559",
                            "name": "cpu",
                            "user_id": "b85463edb60e4a8e936938f3cd444512",
                            "type": "cumulative",
                            "meter_id": "MjlmNTUzNjYtYTY2Zi00MDQzLTk3MmUtZWY4Nzg1NDA2M2RkK2NwdQ==\n"
                    ],
                    [
                            "unit": "%",
                            "resource_id": "29f55366-a66f-4043-972e-ef87854063dd",
                            "source": "openstack",
                            "project_id": "5a876fb5d94d4220b5c8afb228647559",
                            "name": "cpu_util",
                            "user_id": "b85463edb60e4a8e936938f3cd444512",
                            "type": "gauge",
                            "meter_id": "MjlmNTUzNjYtYTY2Zi00MDQzLTk3MmUtZWY4Nzg1NDA2M2RkK2NwdV91dGls\n"
                    ],
                    [
                            "unit": "B",
                            "resource_id": "29f55366-a66f-4043-972e-ef87854063dd",
                            "source": "openstack",
                            "project_id": "5a876fb5d94d4220b5c8afb228647559",
                            "name": "disk.read.bytes",
                            "user_id": "b85463edb60e4a8e936938f3cd444512",
                            "type": "cumulative",
                            "meter_id": "MjlmNTUzNjYtYTY2Zi00MDQzLTk3MmUtZWY4Nzg1NDA2M2RkK2Rpc2sucmVhZC5ieXRlcw==\n"
                    ],
                    [
                            "unit": "request",
                            "resource_id": "29f55366-a66f-4043-972e-ef87854063dd",
                            "source": "openstack",
                            "project_id": "5a876fb5d94d4220b5c8afb228647559",
                            "name": "disk.read.requests",
                            "user_id": "b85463edb60e4a8e936938f3cd444512",
                            "type": "cumulative",
                            "meter_id": "MjlmNTUzNjYtYTY2Zi00MDQzLTk3MmUtZWY4Nzg1NDA2M2RkK2Rpc2sucmVhZC5yZXF1ZXN0cw==\n"
                    ],
                    [
                            "unit": "image",
                            "resource_id": "6aecfac8-576e-4bf4-bc01-09f2f989eadc",
                            "source": "openstack",
                            "project_id": "aecddf2d1ba64f84b315238eb781969d",
                            "name": "image",
                            "user_id": null,
                            "type": "gauge",
                            "meter_id": "NmFlY2ZhYzgtNTc2ZS00YmY0LWJjMDEtMDlmMmY5ODllYWRjK2ltYWdl\n"
                    ],
                    [
                            "unit": "instance",
                            "resource_id": "7b551aa2-5d9b-4112-8490-142c5e6544a5",
                            "source": "openstack",
                            "project_id": "5a876fb5d94d4220b5c8afb228647559",
                            "name": "instance",
                            "user_id": "b85463edb60e4a8e936938f3cd444512",
                            "type": "gauge",
                            "meter_id": "N2I1NTFhYTItNWQ5Yi00MTEyLTg0OTAtMTQyYzVlNjU0NGE1K2luc3RhbmNl\n"
                    ]
            ]]
    private static final DateTime CURRENT_TIME = new DateTime(DateTimeZone.UTC)
    private static final USAGES_REQUEST = [
            'q[0].field': 'timestamp',
            'q[0].op': 'ge',
            'period': INTERVAL,
            'q[0].value': CURRENT_TIME.minusSeconds(INTERVAL * COUNT)
    ]

    private static final USAGES_REQUEST_WITH_TENANT = [
            'q[1].field': 'project_id',
            'q[1].op': 'eq',
            'q[1].value': TENANT.id
    ] + USAGES_REQUEST

    private static final SAMPLES_REQUEST = [
            'q[0].field': 'timestamp',
            'q[0].op': 'ge',
            'q[0].value': CURRENT_TIME.minusSeconds(INTERVAL * COUNT)
    ]

    private static final SAMPLES_REQUEST_WITH_TENANT = [
            'q[1].field': 'project_id',
            'q[1].op': 'eq',
            'q[1].value': TENANT.id
    ] + SAMPLES_REQUEST

    private static final STATISTICS = [[
            duration_end: CURRENT_TIME.minusSeconds(INTERVAL * COUNT),
            period: INTERVAL,
            avg: 1.9700497740283487,
            groupby: null,
            unit: '%'
    ]]
    private static final USAGES = [[
            'x': STATISTICS[0].duration_end,
            'y': STATISTICS[0].avg
    ]]
    private static final SAMPLES_RESP = [[
            timestamp: CURRENT_TIME.minusSeconds(INTERVAL * COUNT),
            counter_volume: 1
    ]]
    private static final SAMPLES = [[
            x: SAMPLES_RESP[0].timestamp,
            y: SAMPLES_RESP[0].counter_volume
    ]]

    @Before
    void setUp() {
        service.timeUtils = [getDate: { CURRENT_TIME }] as TimeUtils
        service.openStackRESTService = mock(OpenStackRESTService)
        service.openStackRESTService.METERING.returns(METERING).stub()
        service.sessionStorageService = mock(SessionStorage)
        service.sessionStorageService.tenant.returns(TENANT).stub()
    }

    def testGetUsages() {
        service.openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$TYPE/statistics", USAGES_REQUEST).returns(STATISTICS)
        play {
            def res = service.getUsages(TYPE, INTERVAL, COUNT, false)
            assertTrue("Required $USAGES, found $res", arrayEquals(USAGES, res))
        }
    }

    def testGetUsagesWithCurrentTenant() {
        service.openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$TYPE/statistics", USAGES_REQUEST_WITH_TENANT).returns(STATISTICS)
        play {
            def res = service.getUsages(TYPE, INTERVAL, COUNT)
            assertTrue("Required $USAGES, found $res", arrayEquals(USAGES, res))
        }
    }

    def testGetUsages2() {
        def statistics = [[
                duration_end: "${CURRENT_TIME.minusSeconds(INTERVAL * COUNT)}.938000",
                period: INTERVAL,
                avg: 1.9700497740283487,
                groupby: null,
                unit: '%'
        ]]
        service.openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$TYPE/statistics", USAGES_REQUEST).returns(statistics).once()
        play {
            def res = service.getUsages(TYPE, INTERVAL, COUNT, false)
            assertTrue("Required $USAGES, found $res", arrayEquals(USAGES, res))
        }
    }

    def testGetUsagesWithCurrentTenant2() {
        def statistics = [[
                duration_end: "${CURRENT_TIME.minusSeconds(INTERVAL * COUNT)}.938000",
                period: INTERVAL,
                avg: 1.9700497740283487,
                groupby: null,
                unit: '%'
        ]]
        service.openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$TYPE/statistics", USAGES_REQUEST_WITH_TENANT).returns(statistics).once()
        play {
            def res = service.getUsages(TYPE, INTERVAL, COUNT)
            assertTrue("Required $USAGES, found $res", arrayEquals(USAGES, res))
        }
    }

    def testGetMeters() {
        service.openStackRESTService.get(OpenStackRESTService.METERING, '/v2/meters').returns(METERS).times(1)
        play {
            assertEquals(METERS, service.getMeters())
        }
    }

    def testGetSamples() {
        service.openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$TYPE", SAMPLES_REQUEST).returns(SAMPLES_RESP).once()
        play {
            def result = service.getSamples(TYPE, INTERVAL * COUNT, false)
            assertTrue("Required $SAMPLES, found $result", arrayEquals(SAMPLES, result))
        }
    }

    def testGetSamplesWithCurrentTenant() {
        service.openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$TYPE", SAMPLES_REQUEST_WITH_TENANT).returns(SAMPLES_RESP).once()
        play {
            def result = service.getSamples(TYPE, INTERVAL * COUNT)
            assertTrue("Required $SAMPLES, found $result", arrayEquals(SAMPLES, result))
        }
    }


    static boolean arrayEquals(def a, def b) {
        if (a.size() != b.size()) {
            return false
        }
        for (int i = 0; i < a.size(); i++) {
            for (int j = 0; j < a[i].size(); j++)
                if (!a[i][j].equals(b[i][j])) {
                    return false
                }
        }
        return true
    }
}
