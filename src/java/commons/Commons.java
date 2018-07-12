/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Nithish Raja.G
 */
package commons;
public class Commons {
    private String emailName = "taskmanager.clri@gmail.com";
    private String emailPassword = "taskmanager@clri";
    private String emailHost = "smtp.gmail.com";
    private String databaseUrl = "jdbc:mysql://localhost:3306/taskmanager";
    private String databaseUsername = "root";
    private String databasePassword = "nithish98";
    private String host = "http://localhost";
    private int port = 8084;
    
    public String getEmailName(){
        return emailName;
    }
    public String getEmailPassword(){
        return emailPassword;
    }
    public String getEmailHost(){
        return emailHost;
    }
    public String getDatabaseUrl(){
        return databaseUrl;
    }
    public String getDatabaseUsername(){
        return databaseUsername;
    }
    public String getDatabasePassword(){
        return databasePassword;
    }
    public String getAddress(){
        return host+":"+port+"/TaskManager/";
    }
}
