package Ehr.common.empl.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class EMPLDAO extends AbstractDAO {

	/**
	 * EDUG010DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EMPLDAO(String p_dsId, TrBox p_tr) throws CException {
		super(p_dsId, p_tr);
	}

	/**
	 *정규직 또는 파견사원명 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EMPL_SHR(CBox p_box) throws CException {

	    String sql      = XmlSqlUtils.getSQL("common", "EMPL_SHR11");
	    
        String ret_cd   = JSPUtil.rns(p_box.getString("RET_CD"));
        String str_ymd  = JSPUtil.rns(p_box.getString("STR_YMD"));
        String end_ymd  = JSPUtil.rns(p_box.getString("END_YMD"));
        String dpt_cd   = JSPUtil.rns(p_box.getString("DPT_CD"));
    

		StringBuffer sb = new StringBuffer();


        //재직자만
        if(ret_cd.equals("1")) {
            sb.append("AND (RET_YMD IS NULL");
            sb.append(" OR  TO_CHAR(RET_YMD, 'YYYYMMDD') >= '"+str_ymd+"')\n");
        }
        //퇴직자만
        else if(ret_cd.equals("2")) {
            sb.append("AND RET_YMD IS NOT NULL");
            sb.append("AND TO_CHAR(RET_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }
        //입사자만
        else if(ret_cd.equals("3")) {
            sb.append("AND TO_CHAR(HIRD_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }
        //전체
        else if(ret_cd.equals("0")) {
            sb.append("AND 1 =1 \n");
        }


		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);
		
		Object[] bind = new Object[] {

				dpt_cd, 
				dpt_cd,    
                //JSPUtil.rns(p_box.getString("ENO_NO")),
                //JSPUtil.rns(p_box.getString("ENO_NO")),    				
                "",
                "",
            
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	public void EMPL_SHR00(CBox p_box) throws CException {

	    String sql      = XmlSqlUtils.getSQL("common", "EMPL_SHR00");
	   
		Object[] bind = new Object[] {
				
                JSPUtil.rns(p_box.getString("ENO_NO")),
                JSPUtil.rns(p_box.getString("ENO_NO")),            
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	public void EMPL_SHR01(CBox p_box) throws CException {

	    String sql      = XmlSqlUtils.getSQL("common", "EMPL_SHR01");
	   
		Object[] bind = new Object[] {
				
                JSPUtil.rns(p_box.getString("ENO_NO")),
                JSPUtil.rns(p_box.getString("ENO_NO")),            
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	public void EMPL_SHR_DH(CBox p_box) throws CException {

	    String sql      = XmlSqlUtils.getSQL("common", "EMPL_SHR11");
	    
        String ret_cd   = JSPUtil.rns(p_box.getString("RET_CD"));
        String str_ymd  = JSPUtil.rns(p_box.getString("STR_YMD"));
        String end_ymd  = JSPUtil.rns(p_box.getString("END_YMD"));
        String dpt_cd   = JSPUtil.rns(p_box.getString("DPT_CD"));
    

		StringBuffer sb = new StringBuffer();


        //재직자만
        if(ret_cd.equals("1")) {
            sb.append("AND (RET_YMD IS NULL");
            sb.append(" OR  TO_CHAR(RET_YMD, 'YYYYMMDD') >= '"+str_ymd+"')\n");
        }
        //퇴직자만
        else if(ret_cd.equals("2")) {
            sb.append("AND RET_YMD IS NOT NULL");
            sb.append("AND TO_CHAR(RET_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }
        //입사자만
        else if(ret_cd.equals("3")) {
            sb.append("AND TO_CHAR(HIRD_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }
        //전체
        else if(ret_cd.equals("0")) {
            sb.append("AND 1 =1 \n");
        }


		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);
		
		Object[] bind = new Object[] {

				dpt_cd, 
				dpt_cd,    
                JSPUtil.rns(p_box.getString("ENO_NO")),
                JSPUtil.rns(p_box.getString("ENO_NO")),    				

            
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	public void EMPL_SHR_DPT(CBox p_box) throws CException {

	    String sql      = XmlSqlUtils.getSQL("common", "EMPL_SHR_DPT");
	   
		Object[] bind = new Object[] {
				
                JSPUtil.rns(p_box.getString("ENO_NO")),
            
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	
	
}
