/*
 * CommUtil
 *
 * Version 1.0
 *
 * Date 2007-06-21
 *
 * Copyright
 *
 * Description �������� ���Ǵ� �Լ��� ����
 */
package Ehr.common.util;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;

public class CommUtil {

    /**
     * ��� ������ ���� DataSet�� �������� ��ȯ �Ѵ�.
     * @param filedName
     * @param resultMsg
     * @return
     */
    public static GauceDataSet getResultDataSet(String filedName, String resultMsg) {
        GauceDataSet gds    = new GauceDataSet();
        GauceDataRow dsRow  = null;

        gds.addDataColumn(new GauceDataColumn(filedName, GauceDataColumn.TB_STRING, 12000));

        dsRow = gds.newDataRow();
        dsRow.addColumnValue(resultMsg);

        gds.addDataRow(dsRow);

        return gds;
    }
    /**
     * FRS �� LibName
     * @return
     */
    public static String getFrsLibName() throws CException{
    	Configuration config = Configuration.getInstance();
		String libName = config.getString("framework.ms.frs.library");
    	return libName;
    }
    /**
     * ��ǥ ÷�θ� ���� html������ ���ϰ��
     * @return
     */
    public static String getHtmlFilePath() throws CException{
    	Configuration config = Configuration.getInstance();
		String filePath = config.getString("framework.html.path.home");

    	return filePath;
    }
    /**
     * ��ǥ ÷�θ� ���� URL ���
     * @return
     */
    public static String getHtmlUrlPath() throws CException{
    	Configuration config = Configuration.getInstance();
		String filePath = config.getString("framework.html.url.home");

    	return filePath;
    }

    /**
     * ��ǥ ÷�θ� ���� URL ���
     * @return
     */
    public static String getEzgenLocaionDNS() throws CException{
    	Configuration config = Configuration.getInstance();
		String filePath = config.getString("framework.print.ezgen.locationDNS");

    	return filePath;
    }
}
