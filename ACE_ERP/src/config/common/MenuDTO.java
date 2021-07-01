package config.common;

import sales.org.application.common.CommonDTO;

public class MenuDTO extends CommonDTO {
    private String          scode;
    private String          scdnm;
    private String          upcode;

    public String    getScode(){return this.scode;}
    public String    getScdnm(){return this.scdnm;}
    public String    getUpcode(){return this.upcode;}

    public void setScode(      String      in){this.scode=in;}
    public void setScdnm(        String    in){this.scdnm=in;}
    public void setUpcode(           String    in){this.upcode=in;}
}
