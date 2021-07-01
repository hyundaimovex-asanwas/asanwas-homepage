package Ehr.eis.t.eist020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST020DAO extends AbstractDAO {
	/**
	 * PIRA060DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// 년월
				p_box.get("TEAM_CD"),				// 팀				
				p_box.get("ENO_NO")					// 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	

	/**
	 * 소속 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_TEAM(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_TEAM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
			
				p_box.get("ENO_NO")					// 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * 일자별 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_DAY(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_DAY");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// 년월
				p_box.get("TEAM_CD"),				// 팀				
				p_box.get("ENO_NO"),				// 사번
				p_box.get("STS")					// 상태				
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * 프로젝트별 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_PJT(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_PJT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// 년월
				p_box.get("TEAM_CD"),				// 팀				
				p_box.get("ENO_NO"),				// 사번
				p_box.get("STS")					// 상태	
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * 직원별 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EIST020_SHR_PER(CBox p_box) throws CException {

		/** 외부 XML에서 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_SHR_PER");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// 년월
				p_box.get("TEAM_CD"),				// 팀				
				p_box.get("ENO_NO"),				// 사번
				p_box.get("STS")					// 상태	
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
     * 저장 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (저장) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_INS");
        
        String ymd[] = JSPUtil.rns(vo.get("STR_YMD")).split("-");
        int quarter = 0;
        int month = 0;
        try {
            month = Integer.parseInt(ymd[1]);
        } catch(Exception e) {
            month = 1;
        }
        
        quarter = ((month-1)/3)+1;
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//년도
                String.valueOf(quarter),			//분기
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),		//신청시작일
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),		//신청종료일
				JSPUtil.rns(vo.get("PAY_YM").replaceAll("-", "")),		//지급년월
				JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),		//지급일자
				p_box.get("vusrid"),
				p_box.get("vusrid")
		};
		

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);

	}
	
	/**
     * 수정 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),		//신청종료일
                JSPUtil.rns(vo.get("PAY_YM").replaceAll("-", "")),      //지급년월
                JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),     //지급일자
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("PIS_YY")),			//년도
				JSPUtil.rns(vo.get("PIS_QQ")),			//분기
                JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),     //신청시작일
		};
		

		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}
	
	
	
	/**
     * 일자별 승인 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_DAY(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_DAY");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),					// 승인, 반송				
                JSPUtil.rns(p_box.get("vusrid")),       // 결재자				
				//p_box.get("ENO_NO"),					// 팀장
				JSPUtil.rns(vo.get("ENO_NO")),			// 팀원				
				JSPUtil.rns(vo.get("REG_YMD")),			// 일자
				JSPUtil.rns(vo.get("PJT_CD")),			// 프로젝트				

		};
				
		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}	
	
	
	/**
     * 일자별 승인 (전체) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_DAY_01(CBox p_box, GauceValueObject vo) throws CException {

        //한큐에 업데이트
		/** 외부 XML에서 목표설정 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_DAY_01");

		/** 삭제 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),									// 승인, 반송				
                JSPUtil.rns(p_box.get("vusrid")),       				// 결재자				
				JSPUtil.rns(vo.get("ENO_NO")),							// 팀원				
				p_box.get("PIS_YM"),									// 년월
		};
		
		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}		
	
	
	/**
     * 프로젝트별 승인 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PJT(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PJT");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),					// 승인, 반송				
                JSPUtil.rns(p_box.get("vusrid")),       // 결재자				
				//p_box.get("ENO_NO"),					// 팀장
				JSPUtil.rns(vo.get("ENO_NO")),			// 팀원				
				JSPUtil.rns(vo.get("REG_YMD")),			// 일자
				JSPUtil.rns(vo.get("PJT_CD")),			// 프로젝트				

		};
				
		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}		
	
	/**
     * 프로젝트별 승인 (전체) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PJT_01(CBox p_box, GauceValueObject vo) throws CException {

        //한큐에 업데이트
		/** 외부 XML에서 목표설정 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PJT_01");

		/** 삭제 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),									// 승인, 반송				
                JSPUtil.rns(p_box.get("vusrid")),       				// 결재자				
				JSPUtil.rns(vo.get("ENO_NO")),							// 팀원				
				p_box.get("PIS_YM"),									// 년월
		};
		
		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}	
	
	
	/**
     * 개인별 승인 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PER(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PER");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),					// 승인, 반송				
                JSPUtil.rns(p_box.get("vusrid")),       // 결재자				
				//p_box.get("ENO_NO"),					// 팀장
				JSPUtil.rns(vo.get("ENO_NO")),			// 팀원				
				JSPUtil.rns(vo.get("REG_YMD")),			// 일자
				JSPUtil.rns(vo.get("PJT_CD")),			// 프로젝트				

		};
				
		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}		
	
	/**
     * 개인별 승인 (전체) DAO 메서드
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_UPT_PER_01(CBox p_box, GauceValueObject vo) throws CException {

        //한큐에 업데이트
		/** 외부 XML에서 목표설정 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_UPT_PER_01");

		/** 삭제 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("STATUS"),									// 승인, 반송				
                JSPUtil.rns(p_box.get("vusrid")),       				// 결재자				
				JSPUtil.rns(vo.get("ENO_NO")),							// 팀원				
				p_box.get("PIS_YM"),									// 년월
		};
		
		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}		
	
	
	/**
     * 삭제 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EIST020_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST020_DEL");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//년도
				JSPUtil.rns(vo.get("PIS_QQ")),			//분기
                JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),     //신청시작일
		};
		

		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}
	

}
