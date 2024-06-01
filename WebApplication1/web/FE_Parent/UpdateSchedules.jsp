<%-- 
    Document   : UpdateSchedules
    Created on : Jun 1, 2024, 3:59:30 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Schedules</title>
    </head>
    <body>
        <h1>Danh sách chương trình học của lớp ${requestScope.classSession.classID.clname} </h1>
  
            <h3 style="color: red">${requestScope.mess}</h3>
    
        
        <table border="1">
            <thead>
                <tr>
                    <th>Lesson</th>
                    <th>Name Activity</th>
                    <th>Date Now</th>
                    <th>Date Update</th>
                    <th>Save</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.listSchedules}" var="s">
                    <tr>
                        <td>${s.sdid.detail}</td>
                        <td>
                            <c:forEach items="${requestScope.listCuri}" var="c">
                                <c:if test="${s.sdid.sdid == c.sdid.sdid}">
                                    ${c.nameAct} <br>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>${s.date}</td>
                        <td>
                            <input type="hidden" class="sdid" value="${s.sdid.sdid}" />
                            <input type="hidden" class="csid" value="${requestScope.csID}" />
                            <input type="date" class="dateUpdate" name="dateUpdate"/>
                        </td>
                        <td>
                            <input type="button" value="Save" onclick="saveRow(this)"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <button onclick="goBack()">Quay Lại</button>

        <script>
            function goBack() {
                // Sử dụng window.location.href để chuyển hướng đến trang mong muốn
                window.location.href = "schedules?csid=${requestScope.csID}&yid=${sessionScope.yidRaw.yid}";
            }

            function saveRow(button) {
                var tr = button.closest('tr');
                var sdid = tr.querySelector('.sdid').value;
                var dateUpdate = tr.querySelector('.dateUpdate').value;
                var csid = tr.querySelector('.csid').value;
                var form = document.createElement('form');
                form.setAttribute('method', 'get');
                form.setAttribute('action', 'updateSchedules');

                var sdidField = document.createElement('input');
                sdidField.setAttribute('type', 'hidden');
                sdidField.setAttribute('name', 'sdid');
                sdidField.setAttribute('value', sdid);

                var dateUpdateField = document.createElement('input');
                dateUpdateField.setAttribute('type', 'hidden');
                dateUpdateField.setAttribute('name', 'dateUpdate');
                dateUpdateField.setAttribute('value', dateUpdate);

                var csidField = document.createElement('input');
                csidField.setAttribute('type', 'hidden');
                csidField.setAttribute('name', 'csid');
                csidField.setAttribute('value', csid);
                form.appendChild(sdidField);
                form.appendChild(dateUpdateField);
                form.appendChild(csidField);
                document.body.appendChild(form);
                form.submit();
            }
        </script>
    </body>
</html>
