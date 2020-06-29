/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.util.List;
import javax.persistence.EntityManager;
import model.bean.Publicacao;
import util.ConnectionFactory;

/**
 *
 * @author paulo
 */
public class PublicacaoDAO {
    public List<Publicacao> getMinhasPublicacoes(String idLogado) {
        EntityManager manager = ConnectionFactory.getEntityManager();
        List<Publicacao> questoes = null;
        try {
            questoes = manager.createQuery("FROM Publicacao p where p.idUsuario =:user")
                    .setParameter("user", idLogado).getResultList(); // verifica se a publicação é do usuário logado
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            manager.close();
        }
        return questoes;
    }
    
    public List<Publicacao> getTodasPublicacoes(String idLogado) {
        EntityManager manager = ConnectionFactory.getEntityManager();
        List<Publicacao> questoes = null;
        try {
            questoes = manager.createQuery("FROM Publicacao p where p.idUsuario !=:user")
                    .setParameter("user", idLogado).getResultList(); // verifica se a publicação é do usuário logado
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            manager.close();
        }
        return questoes;
    }
    
    public List<Publicacao> buscar(String estado, String cidade, String data) {
        EntityManager manager = ConnectionFactory.getEntityManager();
        List<Publicacao> questoes = null;
        try {
            questoes = manager.createQuery("FROM Publicacao  WHERE estado  LIKE '%"+ estado +"%' OR cidade LIKE '%" + cidade + "%' OR data LIKE '%"+ data +"%'")
                    .getResultList(); // verifica se a publicação é do usuário logado
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            manager.close();
        }
        return questoes;
    }
}

