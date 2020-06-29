/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import javax.persistence.EntityManager;
import model.bean.Usuario;
import org.hibernate.Query;
import util.ConnectionFactory;

/**
 *
 * @author paulo
 */
public class UsuarioDAO {
    
    public Long login(String email, String senha) {
        
        EntityManager manager = ConnectionFactory.getEntityManager();
        
        Query query;
        Usuario user;
        try {
            manager.getTransaction().begin();
            query = (Query) manager.createQuery("from Usuario user where user.email =:email")
                    .setParameter("email", email);
            user = (Usuario) query.getSingleResult();
            manager.getTransaction().commit();
            user.setSenha(user.getSenha());
            if (user.getSenha().equals(senha)) {
                return user.getId();
            } else {
                return new Long(-1);
            }
        } catch (Exception e) {
            manager.getTransaction().rollback();
            return null;
        }
    }
}
