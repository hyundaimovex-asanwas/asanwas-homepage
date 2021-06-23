package com.hmm.ejb.http.vo;

import java.io.Serializable;

public class EJBDefVO implements Serializable {

    private String _jndiName;
    private String _home;
    private String _remote;

    public EJBDefVO(String p_jndiName, String p_homeClassName,
                         String p_remoteClassName) {
        _jndiName = p_jndiName;
        _home = p_homeClassName;
        _remote = p_remoteClassName;
    }


    public Class getHomeClass() {
        try {
            return Class.forName(_home);
        } catch (ClassNotFoundException ex) {
            throw new RuntimeException("Unable to load the class : " + _home);
        }
    }

    public Class getRemoteClass() {
        try {
            return Class.forName(_remote);
        } catch (ClassNotFoundException ex) {
            throw new RuntimeException("Unable to load the class : " + _remote);
        }
    }

    public String getRemoteName() {
        return _remote;
    }

    public String getHomeName() {
        return _home;
    }

    public String getJndiName() {
        return _jndiName;
    }

    public boolean equals(Object obj) {
        if (obj instanceof EJBDefVO) {
            EJBDefVO definition = (EJBDefVO) obj;
            if (!(definition.getHomeName().equals(_home))
                    || !(definition.getJndiName().equals(_jndiName))
                    || !(definition.getRemoteName().equals(_remote)))
                return false;
            return true;
        }
        return false;
    }

    public String toString() {
        return "EJB " + _jndiName + " Home class : " + _home;
    }

    public int hashCode() {
        return _jndiName.hashCode();
    }
}



