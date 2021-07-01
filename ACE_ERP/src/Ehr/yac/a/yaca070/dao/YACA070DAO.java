package Ehr.yac.a.yaca070.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class YACA070DAO extends AbstractDAO {
    
	/** 
	 * INSB010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ���� 
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA070DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}
    
    /**
     * JSP�� ���� ������ �߰�
     * Transaction �� ó����������
     * @param p_conn
     * @throws CException
     */
    public YACA070DAO(String p_conn) throws CException {
        super(p_conn);
    }    
	
    /**
     * �ٷμҵ�������Ȳ �˻�
     * @param p_box
     * @throws CException
     */
    public void YACA070_SHR(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA070_SHR");
        
		String USESTS_SHR  = JSPUtil.rns(p_box.get("USESTS_SHR"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		StringBuffer sb = new StringBuffer();

		/** ��ȸ ���ǿ� ���� ó�� **/
		if( USESTS_SHR.equals("Y") ){
			sb.append("AND (PERSON.RET_YMD IS NULL OR PERSON.ENO_NO IN ('3130008','3140016','3140017')) \n");
	     }else if(USESTS_SHR.equals("N")){
			sb.append("AND (PERSON.RET_YMD IS NOT NULL AND PERSON.ENO_NO NOT IN ('3130008','3140016','3140017'))\n");
	     }else{
			sb.append("AND 1=1 \n");			
	     }        
        
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
			};
		
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		Query = SqlUtils.replaceQuery(Query, sqlParam);		
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("PIS_MM"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))            
        };
        
        prop.add("TAX_INCOME" , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MGR_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("BADD_AMT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("SPSB_AMT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GDED_AMT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GOL_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TBL_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WDD_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("OTX_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);        
        
        prop.add("NPEN_DED"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("HIN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LOAN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LONG_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DON_FWD"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("VEN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("INDED_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("PER_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("SAVE_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CARD_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("SAJU_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LSS_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("INDED_EXC"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TTAX_STD"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TAX_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        
        prop.add("HGR_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AGE_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("ANN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MIN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MMA_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("EDU_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GOV1_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GOV2_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LC1_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LC23_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CPC_DED"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("NSE_TOT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("STA_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MRENT_DED"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TDED_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("DGG_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DJM_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DBW_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
       // prop.add("AAA_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AGG_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AJM_TAX"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CONT_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("CCC_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DRE_INTX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DRE_CTTX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DRE_DFTX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("EEE_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    /**
     * �ٷμҵ�������Ȳ �˻�
     * @param p_box
     * @throws CException
     */
    public void YACA070_SHR_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA070_SHR_142");
        
		String USESTS_SHR  = JSPUtil.rns(p_box.get("USESTS_SHR"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		StringBuffer sb = new StringBuffer();

		/** ��ȸ ���ǿ� ���� ó�� **/
		if( USESTS_SHR.equals("Y") ){
			sb.append("AND (PERSON.RET_YMD IS NULL OR PERSON.ENO_NO IN ('3130008','3140016','3140017')) \n");
	     }else if(USESTS_SHR.equals("N")){
			sb.append("AND (PERSON.RET_YMD IS NOT NULL AND PERSON.ENO_NO NOT IN ('3130008','3140016','3140017'))\n");
	     }else{
			sb.append("AND 1=1 \n");			
	     }        
        
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
			};
		
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		Query = SqlUtils.replaceQuery(Query, sqlParam);		
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("PIS_MM"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))            
        };
        
        prop.add("TAX_INCOME" , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MGR_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("BADD_AMT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("SPSB_AMT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GDED_AMT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GOL_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TBL_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WDD_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("OTX_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);        
        
        prop.add("NPEN_DED"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("HIN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LOAN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LONG_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DON_FWD"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("VEN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("INDED_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("PER_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("SAVE_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CARD_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("SAJU_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LSS_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("INDED_EXC"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TTAX_STD"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TAX_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        
        prop.add("HGR_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AGE_AMT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("ANN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MIN_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MMA_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("EDU_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GOV1_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("GOV2_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LC1_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LC23_DED"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CPC_DED"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("NSE_TOT"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("STA_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MRENT_DED"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TDED_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("DGG_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DJM_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DBW_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
       // prop.add("AAA_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AGG_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AJM_TAX"   , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CONT_TAX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("CCC_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DRE_INTX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DRE_CTTX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("DRE_DFTX"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("EEE_TOT"    , ColumnProp.COLUMN_TYPE_FLOAT, 20.0 , ColumnProp.CONSTRAINT_TB_NORMAL);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    
}
