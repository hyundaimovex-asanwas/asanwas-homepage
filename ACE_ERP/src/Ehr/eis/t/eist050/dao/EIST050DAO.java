package Ehr.eis.t.eist050.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST050DAO extends AbstractDAO {
	/**
	 * PIRA060DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST050DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST050_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),				// 년	
				p_box.get("PIS_YM").substring(5, 7),				// 월					
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST050_SHR_TEAM(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_SHR_TEAM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")					// 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
     * 저장 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST050_SAV(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (저장) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_SAV");
        
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				
				
				p_box.get("PIS_YM").substring(0, 4),				// 년	
				p_box.get("PIS_YM").substring(5, 7),				// 월
				
				JSPUtil.rns(vo.get("ENO_NO")),			
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				

				JSPUtil.rns(vo.get("SAL_AMT")),             
				JSPUtil.rns(vo.get("RET_AMT")),
				JSPUtil.rns(vo.get("INS_AMT")),
				JSPUtil.rns(vo.get("LUN_AMT")),             
				JSPUtil.rns(vo.get("WEL_AMT")),
				JSPUtil.rns(vo.get("O7_AMT")),
				JSPUtil.rns(vo.get("BUS_AMT")),             
				JSPUtil.rns(vo.get("PARK_AMT")),
				JSPUtil.rns(vo.get("OIL_AMT")),				
				
				JSPUtil.rns(vo.get("SAL_AMT")),             
				JSPUtil.rns(vo.get("RET_AMT")),
				JSPUtil.rns(vo.get("INS_AMT")),
				JSPUtil.rns(vo.get("LUN_AMT")),             
				JSPUtil.rns(vo.get("WEL_AMT")),
				JSPUtil.rns(vo.get("O7_AMT")),
				JSPUtil.rns(vo.get("BUS_AMT")),             
				JSPUtil.rns(vo.get("PARK_AMT")),
				JSPUtil.rns(vo.get("OIL_AMT")),				
				
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				
				
		};

        
		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);

	}
	
	
	/**
     * 계산하는 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST050_INS_01(GauceValueObject vo, CBox p_box ) throws CException {

		//System.out.println("vo22========="+vo);
		//System.out.println("p_box22========="+p_box);		
		/** 인건비 계산 패키지 실행  **/
		String sql = "{ call PMS.PKG_XF_EIST050.SF_INS_TTX(?, ?, ?, ?) }";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {
				{"IN", 			"", 				JSPUtil.rns(vo.get("PIS_YY")), 			""						},//년
				{"IN", 			"", 				JSPUtil.rns(vo.get("PIS_MM")), 			""						},//월
				{"IN",			"", 				JSPUtil.rns(p_box.get("vusrid")),		""						},//작업자
				{"IN/OUT", 		"MSG", 				"MSG", 									String.valueOf(OracleTypes.VARCHAR)} //작업완료메세지
		};

		/** EXECUTEPROCEDURE 메소드 호출  **/
		CBox box = (CBox)this.executeProcedure(sql, bind, null);		
		
	}	
	
	
	/**
     * 수정 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST050_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_UPT");
		
		System.out.println("vo========="+vo);
		
		
		
		
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
	public void EIST050_DEL(CBox p_box ) throws CException {

		/** 외부 XML에서 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST050_DEL");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),				// 년	
				p_box.get("PIS_YM").substring(5, 7),				// 월

		};
		

		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}
	

}
