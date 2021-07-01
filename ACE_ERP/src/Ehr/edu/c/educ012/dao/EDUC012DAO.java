package Ehr.edu.c.educ012.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUC012DAO extends AbstractDAO {
	/** 
	 * EDUC012DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUC012DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * 교육점수현황
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_01(CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_01");
		
		//System.out.println("EDUC012_SHR_01  =========================================== " + p_box);	    
		
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};
		
		return this.selectProcess(sql, bind, prop);
		
		
	}
	
	/**
	 * 사내교육이력
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_02(CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_02");
		
		//System.out.println("EDUC012_SHR_02  =========================================== " + p_box);	    
		
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY"),
				p_box.get("PLACE_CD")
		};
		
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * 사내강의이력
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_03(CBox p_box) throws CException {
		
		/** 외부 XML에서 후견인등록 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_03");
		
		//System.out.println("EDUC012_SHR_03  =========================================== " + p_box);	   
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
				p_box.get("ENO_NO"),
		};
		
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * 예외자이력
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_05(CBox p_box) throws CException {
		
		/** 외부 XML에서 후견인등록 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_05");
		
		//System.out.println("EDUC012_SHR_05  =========================================== " + p_box);	   
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),				
				p_box.get("ENO_NO"),
		};
		
		return this.selectProcess(sql, bind, prop);
	}

}
