package Ehr.gun.f.gunf080.dao;

import Ehr.common.util.JSPUtil;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF080DAO extends AbstractDAO {
	/**
	 * GUND060DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNF080DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 명단  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {		
				
				p_box.get("DPT_CD"),					
				p_box.get("ENO_NO"),					
				
		};
		
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	
	/**
	 * 스케줄  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_01(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),				
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),				
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),	
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),					
				
				p_box.get("PIS_YM"),
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(4, 6),
				p_box.get("ENO_NO"),					
				
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),

		};

		prop.add("DAY_TOTAL_TIME", ColumnProp.COLUMN_TYPE_DECIMAL, 3.2, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	
	/**
	 * 누적시간  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_DTL(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_DTL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),	
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),		
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),	
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),	
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),
		};

		prop.add("WEEK_TOTAL_TIME", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		prop.add("POSIBLE_TIME", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		prop.add("MONTH_TOTAL_TIME", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		prop.add("POSIBLE_TIME2", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);			
		
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	/**
	 * 자동결재선 조회  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_APP(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_APP");

		/** 조회 조건(조건2)에 따른 처리 #2  상태**/
		StringBuffer sb1 = new StringBuffer();

		// 고성사무소 - 인사팀장
		if (p_box.get("TEAM_CD").equals("CC11")) {
			
			sb1.append("AND B.DPT_CD = 'CC10'\n");
			sb1.append("AND B.DUTY_CD = '41'");
			
		// 도라산 사무소 - 인사팀장
		} else if (p_box.get("TEAM_CD").equals("CC12")) {
			
			sb1.append("AND B.DPT_CD = 'CC10'\n");
			sb1.append("AND B.DUTY_CD = '41'");
			
		// 인천면세점 - 면세사업팀장	
		} else if (p_box.get("TEAM_CD").equals("KK66")) {
			
			sb1.append("AND B.DPT_CD = 'KK65'\n");	
			sb1.append("AND B.DUTY_CD = '41'");
			
		// 초지대교 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I233")) {
			
			sb1.append("AND B.TEAM_CD = 'I233'\n");	
			sb1.append("AND B.DUTY_CD = '20'");			
			
		// 포항안동 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I364")) {
			
			sb1.append("AND B.TEAM_CD = 'I364'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// 태안발전 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I361")) {
			
			sb1.append("AND B.TEAM_CD = 'I361'\n");	
			sb1.append("AND B.DUTY_CD = '20'");			
		
		// 부성지구 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I356")) {
			
			sb1.append("AND B.TEAM_CD = 'I356'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// 신북하수 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I355")) {
			
			sb1.append("AND B.TEAM_CD = 'I355'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// 천안우회 - 토목사업팀장
		} else if (p_box.get("TEAM_CD").equals("I347")) {
			
			sb1.append("AND B.DPT_CD = 'II20'\n");	
			sb1.append("AND B.DUTY_CD = '41'");	
			
		// 시흥능곡 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I192")) {
			
			sb1.append("AND B.TEAM_CD = 'I192'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// 영산강변 - 토목사업팀장
		} else if (p_box.get("TEAM_CD").equals("I171")) {
			
			sb1.append("AND B.DPT_CD = 'II20'\n");	
			sb1.append("AND B.DUTY_CD = '41'");	
			
		// 안양오피스텔 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I374")) {
			
			sb1.append("AND B.TEAM_CD = 'I374'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// 마곡제이스텍 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I373")) {
			
			sb1.append("AND B.TEAM_CD = 'I373'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
						
		// 삼성동위버포레 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I372")) {
			
			sb1.append("AND B.TEAM_CD = 'I372'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// 국가병원 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I371")) {
			
			sb1.append("AND B.TEAM_CD = 'I371'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
				
		// 이천생활숙박 - 현장소장 (영원무역 겸직)
		} else if (p_box.get("TEAM_CD").equals("I369")) {
			
			sb1.append("AND B.TEAM_CD = 'I386'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
					

		// 등촌동 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I368")) {
			
			sb1.append("AND B.TEAM_CD = 'I368'\n");	
			sb1.append("AND B.DUTY_CD = '20'");			
			
		// 삼성동주거복합 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I366")) {
			
			sb1.append("AND B.TEAM_CD = 'I366'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// 양양오색주차장 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I362")) {
			
			sb1.append("AND B.TEAM_CD = 'I362'\n");	
			sb1.append("AND B.DUTY_CD = '20'");		
			
		// 서울대 우석경제관 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I360")) {
			
			sb1.append("AND B.TEAM_CD = 'I360'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
		
		// 영원무역 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I358")) {
			
			sb1.append("AND B.TEAM_CD = 'I358'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
		// 대관령 - 현장소장
		} else if (p_box.get("TEAM_CD").equals("I353")) {
			
			sb1.append("AND B.TEAM_CD = 'I353'\n");	
			sb1.append("AND B.DUTY_CD = '20'");	
			
			
		} else {
			
			sb1.append("AND A.DPT_CD = B.DPT_CD\n");
			sb1.append("AND B.DUTY_CD = '41'");
			
		}
		
		
		Object[] sqlParam = new Object[] {
				
				sb1.toString(),
		
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO"))
		};

		 this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	
	/**
	 * 월별 상신 결재 번호 채번  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_MAX(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_MAX");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	
	
	/**
	 * 개별 상신 결재 번호 채번  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_MAX2(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_MAX2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	

	/**
	 * 조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_SHR_REQ(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_SHR_REQ");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),          // 사번	
				p_box.get("REQ_NO"),		  // REQ_NO
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	/**
	 * 개인별 근무형태 입력
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
		public void GUNF080_SAV(GauceValueObject vo, CBox p_box) throws CException {

			
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_INS");	

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),          // 사번	
				vo.get("REG_YMD"),            // 일자	
				vo.get("WEEK_NO"),            // 주차
				vo.get("STR_TIME"),           // 근무시작시간
				vo.get("STR_MINUTE"),         // 근무시작시간				
				vo.get("END_TIME"),           // 근무종료시간
				vo.get("END_MINUTE"),         // 근무종료시간	
				vo.get("DAY_TOTAL_TIME"),     // 하루근무시간
				//vo.get("STATUS_NOW"),       // STATUS_NOW
				p_box.get("vusrid"),		  // 입력자		
				p_box.get("vusrid"),		  // 수정자	
			
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);		
		
	}
		
		

		/**
		 * 개인별 근무형태 입력
		 * @param p_box
		 * @param vo		GauceValueObject
		 * @throws CException
		 */
			public void GUNF080_UPT(GauceValueObject vo, CBox p_box) throws CException {

				
			/** 외부 XML에서 SQL을 읽어 온다 **/
			String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT");

			//System.out.println(p_box);

			/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
			Object[] bind = new Object[] {
					p_box.get("ENO_NO"),          // 사번	
					vo.get("REG_YMD"),            // 일자	
					vo.get("WEEK_NO"),            // 주차
					vo.get("STR_TIME"),           // 근무시작시간
					vo.get("STR_MINUTE"),         // 근무시작시간				
					vo.get("END_TIME"),           // 근무종료시간
					vo.get("END_MINUTE"),         // 근무종료시간	
					vo.get("DAY_TOTAL_TIME"),     // 하루근무시간
					//vo.get("STATUS_NOW"),         // STATUS_NOW					
					p_box.get("vusrid"),		  // 입력자		
					p_box.get("vusrid"),		  // 수정자	
				
			};

			/** INSERT메소드 호출  **/
			insertProcess(sql, bind);		
			
		}			
		
		
	
	/**
	 * 개인별 근무형태를 삭제하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				vo.get("REG_YMD"),            // 근무형태
				vo.get("ENO_NO"),             // 사번				
				
		};

		/** INSERT메소드 호출  **/
		this.deleteProcess(sql, bind);

	}
	
	
	
	/**
	 * 월별 상신 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),          	// REQ_NO	
				p_box.get("vusrid"),     		// 수정자				
				vo.get("ENO_NO"),          		// 사번	 
				vo.get("REG_YMD"),          	// 날짜	 
		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);		

	}		
	
	
	/**
	 * 개별 상신 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_EACH(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP_EACH");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),          	// REQ_NO	
				p_box.get("vusrid"),     		// 수정자				
				vo.get("ENO_NO"),          		// 사번	 
				vo.get("REG_YMD"),          	// 날짜	 
		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);		

	}		
	
	
	
	/**
	 * 결재 테이블 입력 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("HENO_NO")),
				JSPUtil.rns(vo.get("HJOB_CD")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")+"00",

		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);		

	}	

	
	/**
	 * 결재 테이블 입력 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_01_EACH(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF080_UPT_APP_01_EACH");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("HENO_NO")),
				JSPUtil.rns(vo.get("HJOB_CD")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("GUN_YMD")),

		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);		

	}	
	
	
}
