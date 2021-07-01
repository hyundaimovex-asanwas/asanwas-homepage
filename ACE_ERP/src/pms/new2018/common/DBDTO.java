/*
* [ 수정일자 ][수정자] 내용
* [2018-04-17][이동훈] 
*/
package pms.new2018.common;

import sales.org.application.common.CommonDTO;

public class DBDTO extends CommonDTO {

	private String    	cost_cd;
	private String		plj_nm; 
	private String		group_nm;
	private String		dpt_nm;

	public String         getcost_cd(){return this.cost_cd;      }
	public String         getplj_nm(){return this.plj_nm;      }
	public String         getgroup_nm(){return this.group_nm;      }
	public String         getdpt_nm(){return this.dpt_nm;      }

	public void          setcost_cd(String in) {this.cost_cd    =in; }
	public void          setplj_nm(String in) {this.plj_nm    =in; }
	public void          setgroup_nm(String in) {this.group_nm    =in; }
	public void          setdpt_nm(String in) {this.dpt_nm    =in; }

}
