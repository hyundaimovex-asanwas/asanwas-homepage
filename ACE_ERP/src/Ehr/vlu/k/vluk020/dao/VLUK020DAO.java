package Ehr.vlu.k.vluk020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class VLUK020DAO extends AbstractDAO {
	/**
	 * VLUK020DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public VLUK020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 고과표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void VLUK020_SHR(CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);

		String GBMST_STR  = JSPUtil.rns(p_box.get("GB_MST"));

		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/


		StringBuffer sb = new StringBuffer();

		/** 조회 조건에 따른 처리 **/
		if( ! GBMST_STR.equals("00") ){
			sb.append("AND GB_MST = '"+GBMST_STR+"' \n");
	     }else {
	    	 sb.append("AND 1=1");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
			};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
//		this.selectProcessFirstRow(sql,  null, prop);
	}

	public void VLUK020_SAV(GauceValueObject vo, CBox p_box) throws CException {

		
		//System.out.println(vo);
		//System.out.println(p_box);
		
		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SAV");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
		};
		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}

	public void VLUK020_UPT(GauceValueObject vo, CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);		
		
		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
				,JSPUtil.rns(vo.get("EVAYM"))
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(p_box.get("GB_DTL" ))
		};
		/** CREATE메소드 호출  **/
		this.updateProcess(sql, bind);
	}


	public void VLUK020_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}

	
	public void VLUK020_SHR_DPT(CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);

		String GBMST_STR  = JSPUtil.rns(p_box.get("GB_MST"));

		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SHR_DPT");

		Object[] bind = new Object[] {

		};

		/** FirstRow메소드 호출 **/
//		this.selectProcessFirstRow(sql, bind, prop);
		this.selectProcessFirstRow(sql,  null, prop);
	}

	public void VLUK020_SAV_DPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SAV_DPT");

		int t_scr = Integer.parseInt(vo.get("T_SCR"));		

		/*  근무율  */
		double vg_scr = (double)t_scr*1;
		double g_scr = (double)t_scr*0.85;
		double n_scr = (double)t_scr*0.7;
		double b_scr = (double)t_scr*0.55;
		double vb_scr = (double)t_scr*0.4;			
		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
		        
		        ,JSPUtil.rns(vo.get("T_SCR" ))		   
		        
				,Double.toString(vg_scr)                         	// 월
				,Double.toString(g_scr)                         	// 월
				,Double.toString(n_scr)                         	// 월
				,Double.toString(b_scr)                         	// 월
				,Double.toString(vb_scr)                         	// 월				        
		};
		
		
		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
		
		
		
	}

	public void VLUK020_UPT_DPT(GauceValueObject vo, CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);		
		
		int t_scr = Integer.parseInt(vo.get("T_SCR"));		

		/*  근무율  */
		double vg_scr = (double)t_scr*1;
		double g_scr = (double)t_scr*0.85;
		double n_scr = (double)t_scr*0.7;
		double b_scr = (double)t_scr*0.55;
		double vb_scr = (double)t_scr*0.4;				
		
		
		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_UPT_DPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
		        ,JSPUtil.rns(vo.get("T_SCR" ))		   
		        
				,Double.toString(vg_scr)                         	// 월
				,Double.toString(g_scr)                         	// 월
				,Double.toString(n_scr)                         	// 월
				,Double.toString(b_scr)                         	// 월
				,Double.toString(vb_scr)                         	// 월		
				
				,JSPUtil.rns(vo.get("EVAYM"))
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		};
		/** CREATE메소드 호출  **/
		this.updateProcess(sql, bind);
	}


	public void VLUK020_DEL_DPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_DEL_DPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))

		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
	}
	
	
}
