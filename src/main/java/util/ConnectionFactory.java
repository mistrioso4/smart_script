package util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author eddunic
 */
public class ConnectionFactory {

    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("smart_scriptPU");

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }

}
