<nav class="navbar navbar-background" style="display: flex;">
    <a class="navbar-brand navbar-text-color navbar-align" style="flex:1;text-align: center;" href="https://clri.org/">
        <img src="./../../static/images/clriLogo.png" width="80" height="80" alt="CLRI logo" />
        <h1>CSIR-Central Leather Research Institute</h1>
    </a>
    <div class="nav-item dropleft">
        <a class="nav-link dropdown-toggle" id="navbarDropdown" data-toggle="dropdown"></a>
        <div class="dropdown-menu">
            <div class="dropdown-header">
                <h6><%=session.getAttribute("name")%></h6>
                <p><%=session.getAttribute("department_name")%></p>
            </div>
            <form id="logout" method="POST" action="./../../index.jsp" style="display: none;"></form>
            <div class="dropdown-divider"></div>
            <input form="logout" class="dropdown-item" type="submit" value="Logout" />
        </div>
    </div>
</nav>