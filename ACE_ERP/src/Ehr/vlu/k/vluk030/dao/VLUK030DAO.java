package Ehr.vlu.k.vluk030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class VLUK030DAO extends AbstractDAO {

	public VLUK030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	public void VLUK030_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 평가구조설정 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK030_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK030_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK030_SHR_12(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_SHR_12");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK030_SHR_13(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_SHR_13");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK030_SAV_01(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_SAV_01");

		
		//var OCC_CD = Integer.parseInt(vo.get("T_SCR"));				
		String OCC_CD  = JSPUtil.rns(p_box.get("OCC_CD"));
		String JOB_CD  = JSPUtil.rns(p_box.get("JOB_CD"));
		
		/** 조회 조건에 따른 처리 **/
		/*
		if( OCC_CD.equals("8") &&  !JOB_CD.equals("890")){ //PJT 이면서 계약직이 아니면 
			OCC_CD = "1";
	     }
		*/
		if(JSPUtil.rns(vo.get("OCC_CD")).equals("8")&& JSPUtil.rns(vo.get("JOB_CD")).equals("890")){ //PJT 이면서 계약직이면 직종코드를  한국인계약직으로 변경
			OCC_CD = "3";	
		}else{
			OCC_CD =JSPUtil.rns(vo.get("OCC_CD"));	
		}

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("WRDT" ))
		        ,JSPUtil.rns(vo.get("ENO_NO" ))
		        ,JSPUtil.rns(vo.get("DPT_CD" ))
		        ,JSPUtil.rns(vo.get("JOB_CD" ))
		        ,JSPUtil.rns(vo.get("HIRG_YMD" )).replaceAll("-", "")
		        ,JSPUtil.rns(vo.get("HIR_YMD" )).replaceAll("-", "")
		        ,JSPUtil.rns(vo.get("WRDT" ))
		        ,JSPUtil.rns(vo.get("JPR_YMD" )).replaceAll("-", "")
		        ,JSPUtil.rns(vo.get("GBN_CD" ))
		        ,JSPUtil.rns(vo.get("HIR_CD" ))
		        ,OCC_CD
		        ,JSPUtil.rns(vo.get("HEAD_CD" ))
		        ,JSPUtil.rns(vo.get("DUTY_CD" ))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);		
		
		/** CREATE메소드 호출  **/
		//this.insertProcess(sql, bind);
	}

	public void VLUK030_SAV_02(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_SAV_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("WRDT" ))
		        ,JSPUtil.rns(vo.get("ENO_NO" ))
		        ,JSPUtil.rns(vo.get("DPT_CD" ))
		        ,JSPUtil.rns(vo.get("JOB_CD" ))
		        ,JSPUtil.rns(vo.get("WRDT" ))
		        ,JSPUtil.rns(vo.get("GBN_CD" ))
		        ,JSPUtil.rns(vo.get("HIR_CD" ))
		        ,JSPUtil.rns(vo.get("OCC_CD" ))
		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}


	public void VLUK030_DEL1(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL1");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
		       ,JSPUtil.rns(vo.get("ENO_NO" ))
		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

	public void VLUK030_DEL2(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
			   ,JSPUtil.rns(vo.get("ENO_NO" ))

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

	public void VLUK030_DEL3(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL3");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
			   ,JSPUtil.rns(vo.get("ENO_NO" ))

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

	public void VLUK030_DEL4(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL4");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
		       ,JSPUtil.rns(vo.get("ENO_NO" ))
		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

	public void VLUK030_DEL5(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL5");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
			   ,JSPUtil.rns(vo.get("ENO_NO" ))

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

	public void VLUK030_DEL6(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL6");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월
			   ,JSPUtil.rns(vo.get("ENO_NO" ))

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}


	public void VLUK030_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

	public void VLUK030_DEL_02(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK030_DEL_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", "")                       // 고과년월

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

}
