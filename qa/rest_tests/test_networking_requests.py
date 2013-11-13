from restbasetest import *
from common.rest.networking_helper import NetworkingHelper
from common.rest.compute_helper import InstanceHelper


class TestNetworkingRequests(RESTBaseTest):

    @classmethod
    def setup_class(cls):
        super(TestNetworkingRequests, cls).setup_class()

        cls.net_helper = NetworkingHelper(cls.utils)
        cls.ihelper = InstanceHelper(cls.utils, cls.auth)

        # remove objects to relieve storage
        cls.utils.cleanup_objects(cls.ihelper.terminate_instances, 'instances', id_key='instanceId')

    def teardown(self):
        # delete objects created by test-case
        self.utils.cleanup_objects(self.net_helper.delete_network, 'networkId')
        self.utils.cleanup_objects(self.ihelper.terminate_instances, 'instances', id_key='instanceId')

    def test_list_of_networks(self):
        networks = self.utils.get_list('networks')
        ok_(type(networks) == list, "Unable to get list of volumes.")

    def test_create_network(self):
        tenant = self.auth.tenantId
        network = self.net_helper.create_network({'tenant': 'tenant'})
        # actually, these verifications are already done in create_volume()
        # but the test should contain the checks it was created for.
        ok_(network is not False, "Attempt to create volume failed.")

    def test_show_network(self):
        created = self.net_helper.create_network()
        shown = self.net_helper.show_network(created['id'])
        ok_(created == shown, "'Show network' failed. Expected: %s, Actual: %s." % (created, shown))

    def test_delete_network(self):
        # create volume
        network = self.net_helper.create_network()
        # delete volume
        res = self.net_helper.delete_network(network['id'])
        ok_(res is True, "Unable to delete network.")

# just for local debugging
if __name__ == "__main__":
    t = TestNetworkingRequests()
    t.setup_class()
    t.test_show_network()
    t.teardown()
