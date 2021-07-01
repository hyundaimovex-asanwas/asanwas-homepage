package Ehr.vlu.l.vlul015.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class VLUL015DAO extends AbstractDAO {
	/**
	 * VLUI130DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public VLUL015DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	public void VLUL015_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 평가구조설정 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL015_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("BASIC_YMD_SHR"),                 						// 기준년월
				p_box.get("ENO_NO")                     								 // 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUL015_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 평가구조설정 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL015_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("BASIC_YMD_SHR"),                 						// 기준년월
				p_box.get("ENO_NO")                     								 // 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	

	
	public GauceDataSet VLUL015_SHR_SUB(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL015_SHR_SUB");

		
		//System.out.println("p_box=========="+p_box);
		StringBuffer sb = new StringBuffer();

		if(p_box.get("SUBMIT_SHR").equals("Y")){
			sb.append("AND A.JOBSM IS NOT NULL  \n");
		}else{
			sb.append("AND 1=1 \n");			
		}
		
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);		
		
		Object[] bind = new Object[] {
		
				JSPUtil.rns(p_box.get("REG_YM_SHR")),
				
		};

		return this.selectProcess(sql, bind, prop);
	}		
	
	
	public void VLUL015_UPT_MST(GauceValueObject vo, CBox p_box) throws CException {

		//System.out.println("vo"+vo);
		//System.out.println("p_box"+p_box);
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL015_UPT_MST");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("JOBSM")),
				JSPUtil.rns(vo.get("EDU")),
				JSPUtil.rns(vo.get("MAJOR")),
				JSPUtil.rns(vo.get("SEX")),
				JSPUtil.rns(vo.get("ETC")),
				JSPUtil.rns(vo.get("EXP")),
				JSPUtil.rns(vo.get("CERTIFICATE")),					
				JSPUtil.rns(vo.get("FRGRD")),
				JSPUtil.rns(vo.get("OAGRD")),
				JSPUtil.rns(vo.get("TECH")),
				JSPUtil.rns(vo.get("STUDY")),
				JSPUtil.rns(vo.get("STUDY2")),
				JSPUtil.rns(vo.get("STUDY3")),					
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("EVAYM")),		
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	public void VLUL015_SAV_DTL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL015_SAV_DTL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("EVAYM")),
				JSPUtil.rns(vo.get("SEQ")),
				JSPUtil.rns(vo.get("JOB")),
				JSPUtil.rns(vo.get("TASK")),
				JSPUtil.rns(vo.get("TASKDESC")),
				JSPUtil.rns(vo.get("IMPORT")),
				JSPUtil.rns(vo.get("DEGREE")),
				JSPUtil.rns(vo.get("FREQUENCY")),
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	public void VLUL015_UPT_DTL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL015_UPT_DTL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("JOB")),
				JSPUtil.rns(vo.get("TASK")),
				JSPUtil.rns(vo.get("TASKDESC")),
				JSPUtil.rns(vo.get("IMPORT")),
				JSPUtil.rns(vo.get("DEGREE")),
				JSPUtil.rns(vo.get("FREQUENCY")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("EVAYM")),
				JSPUtil.rns(vo.get("SEQ")),				
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	public void VLUL015_DEL_DTL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL015_DEL_DTL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("EVAYM")),
				JSPUtil.rns(vo.get("SEQ")),
		};
		/** UPDATE메소드 호출  **/
		deleteProcess(sql, bind);
	}
}
