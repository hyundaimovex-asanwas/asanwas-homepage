/*
* [ 수정일자 ][수정자] 내용
* [2012-02-07][심동현] EHR 연결해서 근태현황을 가져오자
*/
package common;

import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;


public class VacDTO extends CommonDTO {
	private String    	eno_no;
	private String		eno_nm; 
	private String		job_cd;
	private String		job_nm;
	private String		dpt_cd;
	private String		dpt_nm;
	private String		day;
	private String		vac;
	private String		dy;
	

	public String         getEmpno(){return this.eno_no;      }
	public String         getEmpnm(){return this.eno_nm;      }
	public String         getJobcd(){return this.job_cd;      }
	public String         getJobnm(){return this.job_nm;      }
	public String         getDptcd(){return this.dpt_cd;      }
	public String         getDptnm(){return this.dpt_nm;      }
	public String         getDay(){return this.day;      }
	public String         getVac(){return this.vac;      }
	public String         getDy(){return this.dy;      }

	public void          setEmpno(String in) {this.eno_no    =in; }
	public void          setEmpnm(String in) {this.eno_nm    =in; }
	public void          setJobcd(String in) {this.job_cd    =in; }
	public void          setJobnm(String in) {this.job_nm    =in; }
	public void          setDptcd(String in) {this.dpt_cd    =in; }
	public void          setDptnm(String in) {this.dpt_nm    =in; }
	public void          setDay(String in) {this.day     =in; }
	public void          setVac(String in) {this.vac     =in; }
	public void          setDy(String in) {this.dy     =in; }
	

}
