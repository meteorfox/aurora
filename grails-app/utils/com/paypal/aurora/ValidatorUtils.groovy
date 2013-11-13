package com.paypal.aurora

class ValidatorUtils {

    def static checkInteger(String value) {
        if (value != null && !value.isInteger()) {
            return 'typeMismatch.java.lang.Integer'
        }
    }

    def static checkDouble(String value) {
        if (value != null && !value.isInteger()) {
            return 'typeMismatch.java.lang.Double'
        }
    }

    static String getGroup(String instanceName) {
        (instanceName =~ /(\D*\d+)?(\D+)\d+\D*/)[0][2]
    }

    static boolean sameGroup(List<String> instanceIds, def instanceService) {
        //[dc][cell][pool][id][side] --- pattern
        List<String> names = [];
        for (id in instanceIds) {
            names.add(instanceService.getById(id).name)
        }
        HashSet<String> groups = new HashSet<String>()
        for (name in names) {
            groups.add(getGroup(name))
        }
        return groups.size() <= 1
    }
}
