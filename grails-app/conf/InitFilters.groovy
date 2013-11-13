
class InitFilters {

    def configService

    static final REDIRECT_TO = ['init': 'auth', 'auth': 'init']
    static final REDIRECT_CONDITION = ['init': true, 'auth': false]

    def filters = {
        all(controller: 'init|auth') {
            before = {
                def nextController = defineRedirect(controllerName)
                if (nextController == controllerName) {
                    return true
                } else {
                    redirect(controller: nextController)
                    return false
                }
            }
        }
    }

    String defineRedirect(String controllerName) {
        if (!configService.production) {
            configService.reloadConfig()
        }
        boolean configState = configService.appConfigured
        if (configState == REDIRECT_CONDITION[controllerName]) {
            return REDIRECT_TO[controllerName]
        }
        return controllerName
    }

}
