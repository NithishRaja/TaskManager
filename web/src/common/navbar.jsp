<nav class="navbar navbar-dark bg-primary">
    <span class="navbar-brand">Task Manager</span>
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link"><%=session.getAttribute("name")%></a>
        </li>
    </ul>
    <form class="form-inline" method="POST" action="./../../index.jsp">
        <input class="btn btn-success" type="submit" name="logout" value="Logout" />
    </form>
</nav>