/*
 * �������� - ���� �� �̰��� ����Ʈ : 2010-09-06 �ɵ���
 * 
 */
package common;

import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;


public class ApDTO extends CommonDTO {
	private int 		cnt;
    private String      detail;
    private String		detail_nm; 

	public long           getCnt(){return this.cnt;      }
	public String         getDetail(){return this.detail;      }
	public String         getDetailNm(){return this.detail_nm;        }

	public void          setCnt		(int   in) {this.cnt     =in; }
	public void          setDetail	(String in) {this.detail    =in; }
	public void          setDetailNm(String in) {this.detail_nm       =in; }
	

}
