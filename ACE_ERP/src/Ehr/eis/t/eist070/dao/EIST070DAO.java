package Ehr.eis.t.eist070.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST070DAO extends AbstractDAO {
	/**
	 * PIRA060DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST070DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST070_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),				// 년	
				p_box.get("PIS_YM").substring(5, 7),				// 월
				p_box.get("PJT_CD"),								// 프로젝트	
				p_box.get("TEAM_CD"),								// 팀				
				p_box.get("ENO_NO"),								// 사번					
				
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	
	/**
	 * 프로젝트 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST070_SHR_PJT(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_SHR_PJT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
			
				
				JSPUtil.rns(p_box.getString("COMM_CD")),								// 프로젝트	
				JSPUtil.rns(p_box.getString("COMM_CD")),								// 프로젝트	
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
     * 저장 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (저장) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_INS");
        
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PJT_CD")),			//프로젝트 코드
				JSPUtil.rns(vo.get("PJT_NM")),			//프로젝트 명		
				JSPUtil.rns(vo.get("DPT_CD")),			//팀 코드
				JSPUtil.rns(vo.get("SEQ")),				//순번
				JSPUtil.rns(vo.get("FROM_YMD")),		//시작일자				
				JSPUtil.rns(vo.get("TO_YMD")),			//종료일자
				JSPUtil.rns(vo.get("USEYN")),			//사용여부
		};

        
		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);

	}
	
	
	/**
     * 계산하는 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_INS_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (저장) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_INS_01");
        
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PJT_CD")),			//프로젝트 코드
				JSPUtil.rns(vo.get("PJT_NM")),			//프로젝트 명		
				JSPUtil.rns(vo.get("DPT_CD")),			//팀 코드
				JSPUtil.rns(vo.get("SEQ")),				//순번
				JSPUtil.rns(vo.get("FROM_YMD")),		//시작일자				
				JSPUtil.rns(vo.get("TO_YMD")),			//종료일자
				JSPUtil.rns(vo.get("USEYN")),			//사용여부
		};

        
		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);

	}	
	
	/**
     * 수정 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_UPT");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("FROM_YMD")),		//시작일
                JSPUtil.rns(vo.get("TO_YMD")),      	//종료일
                JSPUtil.rns(vo.get("USEYN")),     		//사용 여부
				JSPUtil.rns(vo.get("PJT_CD")),			//팀 코드
				JSPUtil.rns(vo.get("DPT_CD")),			//프로젝트 코드
		};
		

		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}
	
	/**
     * 삭제 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST070_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST070_DEL");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//년도
				JSPUtil.rns(vo.get("PIS_QQ")),			//분기

		};
		

		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}
	

}
