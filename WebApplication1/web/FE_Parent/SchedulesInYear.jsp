<%-- 
    Document   : SchedulesInYear
    Created on : May 28, 2024, 8:52:15 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--        <meta name="viewport" content="width=device-width, initial-scale=1">-->

        <title>JSP Page</title>
        <style>
            /* Add your CSS rules here */
            body {
                font-family: Arial, sans-serif;
            }
            table {
                width: 100%;
            }
            th, td {
                padding: 8px;
                text-align: left;
                border-collapse: collapse;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            button {
                padding: 8px 16px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            button:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>

        <form action="schedules" method="get">
            <h3>Select school year</h3>
            <select name="yid" onchange="this.form.submit()">
                
                <c:forEach items="${requestScope.listYearSchool}" var="s">                  
                    <option value="${s.yid}" ${s.yid == requestScope.yid ? 'selected' : ''}> ${s.dateStart} -  ${s.dateEnd}</option>
                </c:forEach>  
            </select> <br/>
            <h3>Select program for one block</h3>
            <select name="csid" onchange="this.form.submit()">
                <c:forEach items="${requestScope.listSession}" var="s">                  
                    <option value="${s.csid}" ${s.csid == requestScope.csID ? 'selected' : ''}> ${s.classID.clname}</option>
                </c:forEach>  
            </select>

        </form>
<c:if test="${requestScope.yearNow.yid == requestScope.yid && (requestScope.listSchedules == null || fn:length(requestScope.listSchedules) > 0)}">

            <form action="schedules" method="get">

                <table border="1">
                    <thead>
                        <tr>
                            <th>Lesson</th>
                            <th>Name Activity</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.listSchedules}" var="s">           
                            <tr>
                        <input type="hidden" name="csidToInsert" value="${requestScope.csID}">
                        <input type="hidden" name="sdid" value="${s.sdid.sdid}">
                        <td> <input type="hidden" name="detail" value="${s.sdid.detail}">${s.sdid.detail}</td>
                        <input type="hidden" name="numbers" value="${s.sdid.sessionNumber}">
                        <td>
                            <c:forEach items="${requestScope.listCuri}" var="c">
                                <c:if test="${s.sdid.sdid == c.sdid.sdid}">
                                    ${c.nameAct} <br>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            ${s.date}
                        </td>
                        <input type="hidden" name="sids" value="${s.sdid.sid.sid}">
                        </tr>                 
                    </c:forEach>  

                    </tbody>
                </table>
                <button>Save</button>
                <button type="button" onclick="location.href='updateSchedules?csid=${requestScope.csID}&yid=${requestScope.yearNow.yid}'">Edit</button>
            </form>
        </c:if>

        <c:if test="${requestScope.yearNow.yid == requestScope.yid && (requestScope.listSchedules == null || fn:length(requestScope.listSchedules) <= 0)}">
            <form action="schedules" method="get">
                <input type="hidden" name="yid" value="${requestScope.yid}">
                <input type="hidden" name="csid" value="${requestScope.csID}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>Lesson</th>
                            <th>Name Activity</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.listSessionDetail}" var="s">                  
                            <tr>
                        <input type="hidden" name="csidToInsert" value="${requestScope.csID}">
                        <input type="hidden" name="sdid" value="${s.sdid}">
                        <td>${s.detail}</td>
           
                        <td>
                            <c:forEach items="${requestScope.listCuri}" var="c">
                                <c:if test="${s.sdid == c.sdid.sdid}">
                                    ${c.nameAct} <br>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <input type="date" name="dateInsert"/>
                        </td>
                         <td><button class="edit-button">Edit</button></td>
                        </tr>                 
                    </c:forEach>  

                    </tbody>
                </table>
                <button type="button" onclick="location.href='updateSchedules?csid=${requestScope.csID}'">Edit</button>
            </form>
                
        </c:if>


        <c:if test="${requestScope.yearNow.yid != requestScope.yid && (requestScope.yearNow.yid > requestScope.yid || requestScope.yearNow.yid < requestScope.yid)}">                      
            <table border="1">
                <thead>
                    <tr>
                        <th>Lesson</th>
                        <th>Name Activity</th>
                        <th>Date</th>
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
                            <td>
                                ${s.date}
                            </td>
                        </tr>                 
                    </c:forEach>  

                </tbody>
            </table>
        </c:if>
    </body>
</html>
