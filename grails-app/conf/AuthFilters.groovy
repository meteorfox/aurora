class AuthFilters {

    def filters = {
        all(controller: "init|info", invert: true) {
            before = {
                // Ignore direct views (e.g. the default main index page).
                if (!controllerName) return true

                // Access control by convention.
                accessControl()
            }
        }
    }

}
