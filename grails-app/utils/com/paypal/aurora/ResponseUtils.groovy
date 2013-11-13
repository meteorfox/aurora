package com.paypal.aurora

import javax.servlet.http.HttpServletResponse

class ResponseUtils {
    static String defineMessageByList(String prefix, List<String> items) {
        if (!items) {
            return ""
        }
        String itemsToString = items.join(',')
        String message = prefix + itemsToString
        return message
    }

    static int defineResponseStatus(Map model, String flashMessage) {
        if (flashMessage || model.notRemovedItems) {
            return HttpServletResponse.SC_INTERNAL_SERVER_ERROR
        }
        return HttpServletResponse.SC_OK
    }
}
