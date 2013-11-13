class LoginHelper():

    def __init__(self, uidriver):
        self.ui = uidriver

    def login(self):
        lab = self.ui.config['lab']
        username = self.ui.config[lab]['username']
        password = self.ui.config[lab]['password']
        if self.check_if_logged_in():
            self.logout()

        #env = self.ui.get_cb_options(self.ui.uimap.cb_environment)
        #self.ui.select_cb_option(self.ui.uimap.cb_environment, env)
        self.ui.enter_text(self.ui.uimap.username_input, username)
        self.ui.enter_text(self.ui.uimap.password_input, password)
        self.ui.click(*self.ui.uimap.login_button)

        self.ui.wait_for_element_present(*self.ui.uimap.logged_as)
        tenant = self.ui.get_cb_options(self.ui.uimap.cb_tenant)
        if "openstack" in tenant:
            self.ui.select_cb_option(self.ui.uimap.cb_tenant, "openstack")
            
    def logout(self):
        if self.check_if_logged_in():
            self.ui.click_menu(self.ui.uimap.logged_as, self.ui.uimap.logout_button)

    def check_if_logged_in(self):
        self.ui.webdriver.implicitly_wait(0)
        status = self.ui.is_element_present(*self.ui.uimap.logged_as)
        self.ui.webdriver.implicitly_wait(self.ui.config['selenium']['implicit_wait'])
        return status