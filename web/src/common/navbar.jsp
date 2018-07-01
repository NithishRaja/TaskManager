<nav class="navbar navbar-dark" style="background-color: rgba(255,165,0,1)">
    <a class="navbar-brand" href="https://clri.org/">
        <img src="./../../static/images/clriLogo.png" width="30" height="30" alt="logo" />
        CSIR-Central Leather Research Institute
    </a>
    <div class="nav-item dropleft">
        <a class="nav-link dropdown-toggle" id="navbarDropdown" data-toggle="dropdown"></a>
        <div class="dropdown-menu">
            <div class="dropdown-header">
                <h6><%=session.getAttribute("name")%></h6>
                <p><%=session.getAttribute("department_name")%></p>
            </div>
            <form id="logout" method="POST" action="./../../index.jsp" style="display: none;"></form>
            <form id="editDetails" method="POST" style="display: none;"></form>
            <input form="editDetails" class="dropdown-item" type="submit" value="Edit Account" />
            <div class="dropdown-divider"></div>
            <input form="logout" class="dropdown-item" type="submit" value="Logout" />
        </div>
    </div>
</nav>