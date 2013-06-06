P.1. Services [program: BILLING PROGRAM, scope: TODAY]
C.1. Capture if patient has health passport or not:
Q.1.1. Patient has Health Passport? [pos: 0, tt_requirenextclick: false, tt_onLoad: __$("nextButton").style.display = "none"]
O.1.1.1. Yes
O.1.1.2. No

C.1. Please select a department
Q.1.2. Department [pos: 1, tt_requirenextclick: false, tt_onLoad: __$("nextButton").style.display = "none", ajaxURL: /billing_departments/get_departments?search_string=, tt_onUnload: setCategoryAjaxURL()]

C.1. Please select a category
Q.1.3. Category [pos: 2, tt_onUnload: setServiceAjaxURL()]

C.1. Please select a service
Q.1.4. Service [pos: 3]


