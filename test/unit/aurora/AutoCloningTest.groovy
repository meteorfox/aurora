package aurora

import com.paypal.aurora.model.DataCenter
import com.paypal.aurora.model.Environment
import com.paypal.aurora.model.OpenStackService

class AutoCloningTest extends GroovyTestCase {

    public void testClone() {
        //prepare some environment
        Environment environment = new Environment()
        environment.name = 'some environment name'

        DataCenter dataCenter = new DataCenter()
        dataCenter.name = 'some data center name'
        dataCenter.flags.add('some flag1')
        dataCenter.flags.add('some flag2')
        environment.datacenters.add(dataCenter)

        OpenStackService customService = new OpenStackService()
        customService.name = "some custom service name"
        customService.monitors.add('some monitor1')
        customService.monitors.add('some monitor2')

        dataCenter.customservices.add(customService)

        //clone environment, equal with clone
        Environment environmentClone = environment.clone()
        assertEquals(environment.name, environmentClone.name)

        //equal with data center clone
        DataCenter dataCenterClone = environmentClone.datacenters.get(0)
        assertEquals(dataCenter.name, dataCenterClone.name)
        assertEquals(dataCenter.flags, dataCenterClone.flags)

        //equal with custom service clone
        OpenStackService customServiceClone = dataCenterClone.customservices.get(0)
        assertEquals(customService.name, customServiceClone.name)
        assertEquals(customService.monitors, customServiceClone.monitors)

        //change properties in environment clone, equal with prototype object
        environmentClone.name = 'some environment name clone'
        assertNotSame(environment.name, environmentClone.name)

        //change properties in data center clone, equal with prototype object
        dataCenterClone.name = 'some data center name clone'
        dataCenterClone.flags.remove(0)
        assertNotSame(dataCenter.name, dataCenterClone.name)
        assertNotSame(dataCenter.flags, dataCenterClone.flags)

        //change properties in custom service clone, equal with prototype object
        customServiceClone.name = "some custom service name clone"
        customService.monitors.remove(0)
        assertNotSame(customService.name, customServiceClone.name)
        assertNotSame(customService.monitors, customServiceClone.monitors)
    }

}
