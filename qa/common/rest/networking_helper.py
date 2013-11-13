from base_rest_helper import *


class NetworkingHelper(BaseRESTHelper):

    def create_network(self, parameters=None):
        params = {
            'name': '',
            'tenant': '',
            'adminState':  'on',
            'shared': 'on',
            'external': 'on'
        }
        # apply non-empty user-defined parameters
        if parameters is not None:
            for k in parameters:
                if parameters[k] != "":
                    params[k] = parameters[k]

        # find and insert values for all required params that are still empty.
        if params['name'] == '':
            networks = self.utils.get_list('networks')
            params['name'] = self.utils.generate_string(4, *[i['name'] for i in networks])

        if params['tenant'] == '':
            tenants = self.utils.get_list('tenants')
            # if len(projects) == 0:
            #     projects.append(self.['volume_type'])
            if len(tenants) > 0:
                params['tenant'] = tenants[0]['name']

        res = self.utils.send_request("POST", 'create_network', data=params)

        # return new volume or raise exception if not created.
        def find_new_network():
            new_network = [x for x in self.utils.get_list('networks')
                       if x['project'] == params['name'] and x['status'] == 'active']
            if len(new_network) == 1:
                return new_network[0]
            else:
                return False
        ok_(self.utils.waitfor(find_new_network, 10, 1), "Creation of volume with 'available' status failed.")
        return find_new_network()

    def show_network(self, id):
        params = {'id': id}
        res = self.utils.send_request('GET', 'show_network', data=params)

        return json.loads(res.content)['network']

    def delete_network(self, id):
        """
        vid - single id (str) or list of ids.
        """
        params = {'selectedNetworks': id}
        res = self.utils.send_request('POST', 'delete_network', data=params)
        # volume cannot be deleted if it is attached or has a snapshot.
        res = json.loads(res.content)
        if len(res['not_deleted_ids']) > 0:
            return False

        if type(id) != list:
            id = [id]
        condition = lambda: len([x for x in self.utils.get_list('network') if v['id'] in vid]) == 0
        return self.utils.waitfor(condition, 200, 5)
