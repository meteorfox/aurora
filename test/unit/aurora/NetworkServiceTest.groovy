package aurora

import com.paypal.aurora.NetworkService
import com.paypal.aurora.OpenStackRESTService
import com.paypal.aurora.QuantumDNSService
import com.paypal.aurora.model.ExternalFloatingIp
import com.paypal.aurora.model.FloatingIp
import com.paypal.aurora.model.SessionStorage
import grails.test.mixin.TestFor
import org.gmock.GMockTestCase
import org.gmock.WithGMock
import org.junit.Before

@WithGMock
@TestFor(NetworkService)
class NetworkServiceTest extends GMockTestCase {

    static final FLOATING_IPS = 'os-floating-ips'
    static final PREFIX = 'v2.0'
    static final POOLS = "os-floating-ip-pools"
    static final EXTERNAL_FLOATING_IPS = 'external_floating_ips'
    static final QUANTUM_FLIP_PATH = 'floatingips'
    static final NOVA = 'compute'
    static final QUANTUM = 'network'

    static final FLIP1 = [id: 'flipId1', pool: 'pool1', ip: '127.0.1.0', fixed_ip: null, instance_id: 'instanceId1']
    static final FLIP2 = [id: 'flipId2', pool: 'pool2', ip: '127.0.2.0', fixed_ip: null, instance_id: null]

    static final EFLIP1 = [id: 'eflipId1', router_id: 'routerId1', tenant_id: 'tenantId1', port_id: 'portId1', fixed_network_id: 'fixedNetworkId1', fixed_ip_address: 'fixedIp1', floating_ip_address: 'floatingIp1']
    static final EFLIP2 = [id: 'eflipId2', router_id: 'routerId2', tenant_id: 'tenantId2', port_id: 'portId2', fixed_network_id: 'fixedNetworkId2', fixed_ip_address: 'fixedIp2', floating_ip_address: 'floatingIp2']

    static final FQDN1 = 'foo1.bar.paypal.com'
    static final FQDN2 = 'foo2.bar.paypal.com'

    static final ZONE = 'paypal.com'
    static final HOST = 'foobar'

    @Before
    void setUp() {
        OpenStackRESTService openStackRESTService = mock(OpenStackRESTService);
        service.openStackRESTService = openStackRESTService
        service.openStackRESTService.NOVA.returns(NOVA).stub()
        service.openStackRESTService.QUANTUM.returns(QUANTUM).stub()

        service.openStackRESTService.get(NOVA, FLOATING_IPS).returns([floating_ips: [FLIP1, FLIP2]]).stub()
        service.openStackRESTService.get(QUANTUM, "$PREFIX/$QUANTUM_FLIP_PATH").returns([floatingips: [EFLIP1, EFLIP2]]).stub()

        SessionStorage sessionStorageService = mock(SessionStorage)
        service.sessionStorageService = sessionStorageService

        service.quantumDNSService = mock(QuantumDNSService)
    }

    def testGetFloatingIpsWithOutQuantumDNSService() {
        service.quantumDNSService.isEnabled().returns(false).stub()

        play {
            assertEquals([new FloatingIp(FLIP1), new FloatingIp(FLIP2)], service.getFloatingIps())
        }

    }

    def testGetFloatingIpsWithQuantumDNSService() {
        service.quantumDNSService.isEnabled().returns(true).stub()
        service.quantumDNSService.getFqdnByIp(FLIP1.ip).returns(FQDN1).times(1)
        service.quantumDNSService.getFqdnByIp(FLIP2.ip).returns(FQDN2).times(1)
        FloatingIp flip1 = new FloatingIp(FLIP1);
        FloatingIp flip2 = new FloatingIp(FLIP2);
        flip1.fqdn = FQDN1
        flip2.fqdn = FQDN2

        play {
            assertEquals([flip1,flip2], service.getFloatingIps())
        }

    }

    def testGetUnassignedFloatingIps() {
        service.quantumDNSService.isEnabled().returns(false).stub()

        play {
            assertEquals([new FloatingIp(FLIP2)], service.getUnassignedFloatingIps())
        }

    }

    def testGetExternalFloatingIps() {
        play {
            assertEquals([new ExternalFloatingIp(EFLIP1), new ExternalFloatingIp(EFLIP2)], service.getExternalFloatingIps())
        }
    }

    def testGetExternalFloatingIpsMap() {

        def map = [:]
        map[EFLIP1.fixed_ip_address] = EFLIP1.floating_ip_address
        map[EFLIP2.fixed_ip_address] = EFLIP2.floating_ip_address

        play {
            assertEquals(map, service.getExternalFloatingIpsMap())
        }
    }

    def testGetFloatingIpsForInstance() {
        service.quantumDNSService.isEnabled().returns(false).stub()

        play {
            assertEquals([new FloatingIp(FLIP1)], service.getFloatingIpsForInstance(FLIP1.instance_id))
        }

    }

    def testGetFloatingIpById() {
        service.openStackRESTService.get(NOVA, "$FLOATING_IPS/$FLIP1.id").returns([floating_ip: FLIP1])

        play {
            assertEquals(new FloatingIp(FLIP1), service.getFloatingIpById(FLIP1.id))
        }

    }

    def testGetFloatingIpPools(){
        service.openStackRESTService.get(NOVA, POOLS).returns([floating_ip_pools: [[name: FLIP1.pool]]])
        play {
            assertEquals([[name: FLIP1.pool]], service.floatingIpPools)
        }
    }

    def testAllocateFloatingIpWithOutQuantumDNSService() {
        service.openStackRESTService.post(NOVA, FLOATING_IPS, [pool: FLIP1.pool]).returns([floating_ip: FLIP1]).times(1)
        service.quantumDNSService.isEnabled().returns(false).stub()

        play {
            assertEquals([floating_ip: FLIP1], service.allocateFloatingIp(FLIP1.pool))
        }
    }

    def testAllocateFloatingIpWithQuantumDNSService() {
        service.openStackRESTService.post(NOVA, FLOATING_IPS, [pool: FLIP1.pool]).returns([floating_ip: FLIP1]).times(1)
        service.quantumDNSService.isEnabled().returns(true).stub()
        service.quantumDNSService.addDnsRecord(HOST, FLIP1.ip, ZONE).returns().times(1)

        play {
            assertEquals([floating_ip: FLIP1], service.allocateFloatingIp(FLIP1.pool, HOST, ZONE, true))
        }
    }

    def testAllocateFloatingIpWithoutQuantumDNSService() {
        service.openStackRESTService.post(NOVA, FLOATING_IPS, [pool: FLIP1.pool]).returns([floating_ip: FLIP1]).times(1)
        service.quantumDNSService.isEnabled().returns(true).stub()

        play {
            assertEquals([floating_ip: FLIP1], service.allocateFloatingIp(FLIP1.pool))
        }
    }

    def testReleaseFloatingIpWithOutQuantumDNSService() {
        service.openStackRESTService.delete(NOVA, "$FLOATING_IPS/$FLIP1.id").returns(null).times(1)
        service.quantumDNSService.isEnabled().returns(false).stub()

        play {
            assertNull(service.releaseFloatingIp(FLIP1.id))
        }
    }

    def testReleaseFloatingIpWithQuantumDNSService() {
        service.openStackRESTService.delete(NOVA, "$FLOATING_IPS/$FLIP1.id").returns(null).times(1)
        service.quantumDNSService.isEnabled().returns(true).stub()
        service.openStackRESTService.get(NOVA, "$FLOATING_IPS/$FLIP1.id").returns([floating_ip: FLIP1])
        service.quantumDNSService.deleteDnsRecordByIP(FLIP1.ip).returns().times(1)

        play {
            assertNull(service.releaseFloatingIp(FLIP1.id))
        }
    }

    def testAssociateFloatingIp() {
        service.openStackRESTService.post(NOVA, "servers/$FLIP1.instance_id/action", [addFloatingIp: [address: FLIP1.ip]]).returns([]).times(1)
        play {
            assertEquals([], service.associateFloatingIp(FLIP1.instance_id, FLIP1.ip))
        }
    }

    def testDisassociateFloatingIp() {
        service.openStackRESTService.post(NOVA, "servers/$FLIP1.instance_id/action", [removeFloatingIp: [address: FLIP1.ip]]).returns([]).times(1)
        play {
            assertEquals([], service.disassociateFloatingIp(FLIP1.instance_id, FLIP1.ip))
        }
    }

    def testIsUseExternalFLIP() {
        service.sessionStorageService.isFlagEnabled(EXTERNAL_FLOATING_IPS).returns(true).times(1)

        play {
            assertTrue(service.isUseExternalFLIP())
        }
    }

}
