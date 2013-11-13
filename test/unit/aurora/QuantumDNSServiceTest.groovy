package aurora

import com.paypal.aurora.OpenStackRESTService
import com.paypal.aurora.QuantumDNSService
import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.model.SessionStorage
import grails.test.mixin.TestFor
import org.gmock.GMockTestCase
import org.gmock.WithGMock
import org.junit.Before

@WithGMock
@TestFor(QuantumDNSService)
class QuantumDNSServiceTest extends GMockTestCase {

    static final String DNS = 'dns'
    static final String HOST = 'foo'
    static final String IP = '1.2.3.4'
    static final String ZONE = 'host.com'
    static final String OCTET = IP.split('\\.')[3] + '.' + IP.split('\\.')[2]
    static final String ZONE_FOR_DELETE = IP.split('\\.')[1] + '.' + IP.split('\\.')[0] + '.in-addr.arpa'

    static final String FULLY_QUALIFIED_NAME = "$HOST.$ZONE"
    static final def SUCCESS_RESPONSE = [message:'Operation Completed Successfully']
    static final def DNS_RECORDS = [records: [[
            resourceType: 'A',
            records: [[
                    recordName: HOST,
                    timeToLive: 300,
                    ipAddresses: [IP]
            ]]
    ], [
            resourceType: 'PTR',
            records: [[
                    recordName: '4',
                    timeToLive: 300,
                    fullyQualifiedName: FULLY_QUALIFIED_NAME
            ]]
    ]
    ]]
    static final FULLY_QUALIFIED_MAP = [
            resourceType: 'PTR',
            timeToLive: 300,
            viewName: 'internal',
            zoneName: '2.1.in-addr.arpa',
            fullyQualifiedName: FULLY_QUALIFIED_NAME,
            recordName: '4.3'
    ]
    private static final String[] WRONG_ZONES = ['wrong_zone']
    private static final def DNS_RECORDS_PPP = [records: [[
            resourceType: 'A',
            records: [[
                    recordName: HOST,
                    timeToLive: 300,
                    ipAddresses: [IP]
            ]]
    ], [
            resourceType: 'PTR',
            records: [[
                    recordName: '4',
                    timeToLive: 300,
                    fullyQualifiedName: "${HOST}.ppp.${ZONE}"
            ]]
    ]
    ]]


    @Before
    void setUp() {
        service.openStackRESTService = mock(OpenStackRESTService)
        service.openStackRESTService.DNS.returns(DNS).stub()
        service.sessionStorageService = mock(SessionStorage)
    }

    def testAddDnsRecord() {
        service.openStackRESTService.post(DNS, ZONE, DNS_RECORDS).returns(SUCCESS_RESPONSE)
        play {
            assertEquals(SUCCESS_RESPONSE, service.addDnsRecord(HOST, IP, ZONE))
        }
    }

    def testAddDnsRecordPPP() {
        service.openStackRESTService.post(DNS, "ppp.${ZONE}", DNS_RECORDS_PPP).returns(SUCCESS_RESPONSE)
        play {
            assertEquals(SUCCESS_RESPONSE, service.addDnsRecord(HOST, IP, ZONE, true))
        }
    }

    def testDeleteDnsRecord() {
        service.openStackRESTService.post(DNS, "$ZONE/action/delete", DNS_RECORDS).returns(SUCCESS_RESPONSE)
        play {
            assertEquals(SUCCESS_RESPONSE, service.deleteDnsRecord(HOST, IP, ZONE))
        }
    }

    def testDeleteDnsRecordPPP() {
        service.openStackRESTService.post(DNS, "ppp.${ZONE}/action/delete", DNS_RECORDS_PPP).returns(SUCCESS_RESPONSE)
        play {
            assertEquals(SUCCESS_RESPONSE, service.deleteDnsRecord(HOST, IP, ZONE, true))
        }
    }

    def testGetFqdnByIp() {
        service.openStackRESTService.get(DNS, '2.1.in-addr.arpa/recordtypes/ptr/records/4.3').returns(FULLY_QUALIFIED_MAP)
        play {
            assertEquals(FULLY_QUALIFIED_NAME, service.getFqdnByIp(IP))
        }
    }

    def testGetFqdnByIpWithException() {
        service.openStackRESTService.get(DNS, '2.1.in-addr.arpa/recordtypes/ptr/records/4.3').raises(new RestClientRequestException("message")).times(1)
        play {
            assertNull(service.getFqdnByIp(IP))
        }
    }

    def testGetIpByHostnameAndZone() {
        service.openStackRESTService.get(DNS, 'sjnlab.paypal.com/recordtypes/a/records/ANGR1').returns([
                resourceType: 'A',
                timeToLive: 300,
                viewName: 'internal',
                zoneName: 'sjnlab.paypal.com',
                ipAddresses: ['172.18.98.19'],
                recordName: 'ANGR1'
        ])
        play {
            assertEquals('172.18.98.19', service.getIpByHostnameAndZone('ANGR1', 'sjnlab.paypal.com'))
        }
    }

    def testGetIpByHostnameAndZoneWithException() {
        service.openStackRESTService.get(DNS, 'sjnlab.paypal.com/recordtypes/a/records/ANGR1').raises(new RestClientRequestException("message")).times(1)
        play {
            assertNull(service.getIpByHostnameAndZone('ANGR1', 'sjnlab.paypal.com'))
        }
    }

    def testGetIpByHostnameAndZoneNegative() {
        service.openStackRESTService.get(DNS, "$ZONE/recordtypes/a/records/$HOST").returns([message: 'No Resource Found'])
        play {
            assertNull(service.getIpByHostnameAndZone(HOST, ZONE))
        }
    }

    def testIsServiceEnabled() {
        service.openStackRESTService.isServiceEnabled(DNS).returns(true).times(1)

        play {
            assertTrue(service.isEnabled())
        }
    }

    def testDeleteDnsRecordByIp() {
        service.openStackRESTService.post(DNS, "$ZONE/action/delete", DNS_RECORDS).returns(SUCCESS_RESPONSE).times(1)
        service.openStackRESTService.get(DNS, "$ZONE_FOR_DELETE/recordtypes/ptr/records/$OCTET").returns(FULLY_QUALIFIED_MAP).times(1)
        service.sessionStorageService.getTenant().returns(zones: [ZONE]).times(1)

        play {
            assertEquals(SUCCESS_RESPONSE, service.deleteDnsRecordByIP(IP))
        }
    }

    def testDeleteDnsRecordByIpWithException() {
        service.openStackRESTService.get(DNS, "$ZONE_FOR_DELETE/recordtypes/ptr/records/$OCTET").returns(FULLY_QUALIFIED_MAP).times(1)
        service.sessionStorageService.getTenant().returns(zones: WRONG_ZONES).times(1)

        play {
            def message = shouldFail(RuntimeException) {
                service.deleteDnsRecordByIP(IP)
            }
            assertEquals("Can not delete $IP from UDNS service. FQDN: $FULLY_QUALIFIED_NAME , but zones: $WRONG_ZONES", message)
        }
    }

    def testDeleteDnsRecordByIpNegative() {
        service.openStackRESTService.get(DNS, "$ZONE_FOR_DELETE/recordtypes/ptr/records/$OCTET").raises(new RestClientRequestException("message")).times(1)
        play {
            assertNull(service.deleteDnsRecordByIP(IP))
        }
    }
}
