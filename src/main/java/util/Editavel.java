/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

/**
 *
 * @author paulo
 */
public class Editavel {
    private String diretorio;

    public Editavel() {
        this.diretorio = "/home/paulo/Área de trabalho/projetos/smart_script/src/main/webapp/upload";
    }

    public String getDiretorio() {
        return diretorio;
    }

    public void setDiretorio(String diretorio) {
        this.diretorio = diretorio;
    }
    
    
}
