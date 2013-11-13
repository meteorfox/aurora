package aurora

import com.paypal.aurora.model.OpenStackService
import grails.test.mixin.TestFor

@TestFor(OpenStackService)
class OpenStackServiceTest {

    void testFormatHost() {
        assertEquals('host.com', OpenStackService.formatHost('http://host.com'))
        assertEquals('host.com', OpenStackService.formatHost('host.com'))
        assertEquals('host.com', OpenStackService.formatHost('http://host.com:8080/'))
        assertEquals('host.com', OpenStackService.formatHost('http://host.com/foo/bar'))
        assertEquals('host.com', OpenStackService.formatHost('http://host.com:123/foo'))
    }
}
