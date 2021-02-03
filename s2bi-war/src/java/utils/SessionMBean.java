package utils;

import entities.Periodecosting;
import entities.Utilisateur;
import java.util.ArrayList;
import java.util.List;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import static utils.SessionMBean.getSession;

public class SessionMBean {

    public static HttpSession getSession() {
        return (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);
    }

    public static HttpServletRequest getRequest() {
        return (HttpServletRequest) FacesContext.getCurrentInstance()
                .getExternalContext().getRequest();
    }

    public static String getUserName() {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);
        return session.getAttribute("login").toString();
    }

    public static String getUserId() {
        HttpSession session = getSession();
        if (session != null) {
            return (String) session.getAttribute("utilisateurid");
        }
        return null;
    }

    public static Utilisateur getUserAccount() {
        HttpSession session = getSession();
        if (session != null) {
            return (Utilisateur) session.getAttribute("compte");
        }
        return null;
    }

    public static Boolean getSession1() {
        HttpSession session = getSession();
        if (session != null) {
            return (Boolean) session.getAttribute("session");
        }
        return false;
    }

    public static List<Long> getAccess() {
        HttpSession session = getSession();
        if (session != null) {
            return (List<Long>) session.getAttribute("accesses");
        } else {
            return null;
        }
    }

    public static Periodecosting getPeriodeCosting() {
        HttpSession session = getSession();
        if (session != null) {
            return (Periodecosting) session.getAttribute("costing");
        }
        return null;
    }

    public static List<Periodecosting> getPeriodeCostings() {
        HttpSession session = getSession();
        if (session != null) {
            return (List<Periodecosting>) session.getAttribute("costings");
        }
        return new ArrayList<>();
    }
}
