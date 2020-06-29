package model.dao;

import javax.persistence.EntityManager;
import util.ConnectionFactory;

/**
 *
 * @author eddunic
 * @param <T>
 */
public class GenericDAO<T extends BaseEntity> {
    
    public T findById(Class<T> clazz, Long id) {
        EntityManager manager = ConnectionFactory.getEntityManager();
        return manager.find(clazz, id);
    }

    public void saveOrUpdate(T obj) {
        EntityManager manager = ConnectionFactory.getEntityManager();
        try {
            manager.getTransaction().begin();
            if (obj.getId() == null) {
                manager.persist(obj);
            } else {
                manager.merge(obj);
            }
            manager.getTransaction().commit();
        } catch (Exception e) {
            manager.getTransaction().rollback();
        }
    }
//
//    public void remove(Class<T> clazz, Long id) {
//        EntityManager manager = ConnectionFactory.getEntityManager();
//        T t = findById(clazz, id);
//        try {
//            manager.getTransaction().begin();
//            manager.remove(t);
//            manager.getTransaction().commit();
//        } catch (Exception e) {
//            manager.getTransaction().rollback();
//        }
//    }

    
    private final static EntityManager manager = ConnectionFactory.getEntityManager();

    public T findById2(Class<T> clazz, Long id) {
        manager.getTransaction().begin();
        return manager.find(clazz, id);
    }

    public void remove(T t) {
        manager.merge(t);
        manager.remove(t);
        manager.getTransaction().commit();
    }
    
}
