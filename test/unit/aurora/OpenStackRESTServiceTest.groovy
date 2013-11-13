package aurora

import com.paypal.aurora.OpenStackRESTService
import com.paypal.aurora.model.OpenStackService
import com.paypal.aurora.model.SessionStorage
import grails.test.mixin.TestFor
import org.gmock.GMockTestCase
import org.gmock.WithGMock
import org.junit.Before

@WithGMock
@TestFor(OpenStackRESTService)
class OpenStackRESTServiceTest extends GMockTestCase {

    static String SERVICE = 'service'

    @Before
    void setUp() {
        SessionStorage sessionStorageService = mock(SessionStorage)
        service.sessionStorageService = sessionStorageService
    }

    void testIsServiceEnabled() {
        OpenStackService oss = new OpenStackService()
        oss.disabled = false
        service.sessionStorageService.getServices().returns([(SERVICE): oss]).stub()
        play {
            assertTrue(service.isServiceEnabled(SERVICE))
        }
    }

    void testIsServiceEnabledForNull() {
        service.sessionStorageService.getServices().returns([:]).stub()
        play {
            assertFalse(service.isServiceEnabled(SERVICE))
        }
    }

}
