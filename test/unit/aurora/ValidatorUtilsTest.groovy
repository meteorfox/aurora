package aurora

import com.paypal.aurora.ValidatorUtils
import grails.test.mixin.TestFor

@TestFor(ValidatorUtils)
class ValidatorUtilsTest {

    void testGetGroup() {
        assertEquals('foo', ValidatorUtils.getGroup('foo123'))
        assertEquals('foo', ValidatorUtils.getGroup('bar12foo123'))
        assertEquals('foo', ValidatorUtils.getGroup('foo123a'))
        assertEquals('foo', ValidatorUtils.getGroup('bar12foo123b'))
        assertEquals('foo', ValidatorUtils.getGroup('12foo123'))
    }

}
