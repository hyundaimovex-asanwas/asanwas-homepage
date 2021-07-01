/*
 * 서브포털 - 관광 용 미결함 리스트 : 2010-09-06 심동현
 * 
 */
package sales.menu.my;

import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;


public class My400DTO extends CommonDTO {
	private long           ap_m_sid;
    private String         doc_gu_nm;
    private String         i_empnm; 
	private String         i_date;

	public long           getAp_m_sid(){return this.ap_m_sid;      }
	public String         getDoc_gu_nm(){return this.doc_gu_nm;      }
	public String         getI_empnm(){return this.i_empnm;        }
	public String         getI_date(){return this.i_date;        }


	public void          setAp_m_sid		(long   in) {this.ap_m_sid     =in; }
	public void          setDoc_gu_nm		(String in) {this.doc_gu_nm    =in; }
	public void          setI_empnm			(String in) {this.i_empnm       =in; }
	public void          setI_date			(String in) {this.i_date       =in; }
	

}
