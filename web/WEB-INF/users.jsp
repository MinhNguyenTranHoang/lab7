<%-- 
    Document   : users
    Created on : 10-Jul-2022, 1:19:40 AM
    Author     : MINH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        <style>
            .addUser {
                float: left;
            }
            
            .manageUsers {
                float: left;
            }
            
            .editUser {
                float: left;
            }
                                
            table {
                border-collapse: collapse;
            }

            td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            tr:nth-child(even) {
                background-color: #dddddd;
            }
        </style>
    </head>
    <body>
        <div class="addUser">
        <h1>Add User</h1>
        <form action="user" method="post">
            <input type="email" name="add_email" placeholder="Email">
            <br>
            <input type="checkbox" name="add_active" value="true">Active
            <br>
            <input type="text" name="add_first_name" placeholder="First Name">
            <br>
            <input type="text" name="add_last_name" placeholder="Last Name">
            <br>
            <input type="password" name="add_password" placeholder="Password">
            <br>
            <select name="add_roles" id="roles">
                <option value="1">system admin</option>
                <option value="2">regular user</option>
                <option value="3">company admin</option>
            </select>
            <br>
            <input type="hidden" name="action" value="add">
            <input type="submit" value="Add">
        </form>
        </div>
        <div class="manageUsers">
        <h1><center>Manage Users</center></h1>
        <c:if test="${not empty userList}">
            <table>
                <tr>
                    <th>Email</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Role</th>
                    <th>Active</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <c:forEach var="userList" items="${userList}">
                    <tr>
                        <td>${userList.email}</td>
                        <td>${userList.first_name}</td>
                        <td>${userList.last_name}</td>
                        <c:forEach var="roleList" items="${roleList}">
                            <c:if test="${userList.role == roleList.role_id}">
                                <td>${roleList.role_name}</td>
                            </c:if>
                        </c:forEach>
                        <td>
                            <c:choose>
                                <c:when test="${userList.active}">
                                    <c:set var="Yes" value="true" />Yes
                                </c:when>
                                <c:otherwise>
                                    <c:set var="No" value="false" />No  
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:url value="/user" var="urlEdit">
                                <c:param name="action" value="edit" />
                                <c:param name="email" value="${userList.email}" />
                            </c:url>
                            <a href=${urlEdit}>Edit</a>
                        </td>
                        <td>
                            <c:url value="/user" var="urlDelete">
                                <c:param name="action" value="delete" />
                                <c:param name="email" value="${userList.email}" />
                            </c:url>
                            <a href=${urlDelete}>Delete</a>
                        </td>
                    </tr>
                </c:forEach>    
            </table>
        </c:if>
        </div>
        <div class="editUser">
        <h1>Edit User</h1>
        <form action="user" method="post">
            <input type="hidden" name="edit_email" placeholder="Email" value="${edit_email}">
            <c:choose>
                <c:when test="${edit_active == true}">
                    <input type="checkbox" name="edit_active" checked="checked" value="true" />
                </c:when>
                <c:otherwise>
                    <input type="checkbox" name="edit_active" value="true" />
                </c:otherwise>
            </c:choose>    
            Active
            <br>
            <input type="text" name="edit_first_name" placeholder="First Name" value="${edit_first_name}">
            <br>
            <input type="text" name="edit_last_name" placeholder="Last Name" value="${edit_last_name}">
            <br>
            <input type="hidden" name="edit_password" placeholder="Password" value="${edit_password}">
            <select name="edit_roles">
                <c:forEach items="${roleList}" var="role">
                    <option value="${role.role_id}" ${role.role_id == edit_roles ? 'selected' : ''}>${role.role_name}</option>
                </c:forEach>
            </select>
            <br>
            <input type="hidden" name="action" value="edit">
            <input type="submit" value="Update">
        </form>
        </div>
    </body>
</html>
