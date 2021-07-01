package sales.org.util;

/**
 * ��뷮 ��ũ�� ���� �����ڿ� ��õ� ������ (byte����)�� �����Ͽ� enumerate ��ü��
 * ������ �д�. ����� ���� ByteUtil �� �޼ҵ带 �̿��� ���� ���� �� �ִ�. <br>
 * ������ ���̽��� ��뷮 Ÿ�� �ڷḦ ���� ���� ��� VARCHAR2() Ÿ������ ������ ���� ���̺��� 
 * �����ؼ� �������� row�� ������ ���� �� ��� �����ϰ� ���� �� �ִ�.<br>  
 * 
 * <pre>
 * 	<��뿹>		
 * 
 * 	ArrayList token = new ArrayList();			// ����� 
 * 
 * 	String contents = "XXXX.........XXXX";		// ��뷮 ��Ʈ��
 * 
 *	ByteUtil byteUtil = new ByteUtil(contents, 3000);	// 3000bytes ������ �Ľ��Ѵ�.
 *			
 *	int i = 0;
 *
 *	while(byteUtil.hasNext())
 *		token.add(byteUtil.nextToken());		// 3000bytes �� ����ҿ� �����Ѵ�.
 * </pre>
 * 
 * @author pronema
 *
 */
public class ByteUtil
{
    private static final String CUT_POSTFIX = "...";

    private byte[] buffer;
    private int tokenSize;
    private int workingIndex;

    /**
     * ������ ���� ���� ��Ʈ���� �Ľ� ������(byte ����)�� ���� �޴´�.
     * 
     * @param string		<code>���� ���ڿ�</code>
     * @param tokenSize	<code>������ (byte����)</code>
     * 
     */
    public ByteUtil(String string, int tokenSize)
    {
        this(string.getBytes(), tokenSize);
    }

    /**
     * ������ ���� ���� ��Ʈ���� ���� �� byte�迭�� �Ľ� ������(byte ����)�� ���� �޴´�.
     * 
     * @param buffer		<code>��뷮 ���ڿ��� ����� byte �迭</code>
     * @param tokenSize	<code>������ (byte����)</code>
     * 
     */
    public ByteUtil(byte[] buffer, int tokenSize)
    {
        this.buffer = buffer;
        this.tokenSize = tokenSize;

        workingIndex = 0;
    }

    /**
     * �Ľ��� �κ��� �����ϴ��� üũ�Ѵ�.
     * 
     * @return <code>���� ���� (ture : ������, false : ���� ����)</code> 
     * 
     */
    public boolean hasNext()
    {
        if (workingIndex < buffer.length) return true;
        return false;
    }

    /**
     * �Ľ��� ���ڿ��� �����Ѵ�.
     * 
     * @return <code>�Ľ̵� ���ڿ�</code> 
     * 
     */
    public String nextToken()
    {
        if (!hasNext()) return null;

        int workingTokenSize = tokenSize;
        
        if (getExpectedIndex(workingTokenSize) > buffer.length - 1) 
        	workingTokenSize = buffer.length - workingIndex;

        int backStepCounter = 0;
        
        while (true)
        {
            int testIndex = getExpectedIndex(workingTokenSize) - 1 - backStepCounter;

            if(workingIndex > testIndex) 
            	break;

            byte testByte = buffer[testIndex];
            
            if (testByte >= 0 && testByte <= 255) 
            	break;

            backStepCounter++;
        }

        workingTokenSize -= backStepCounter % 2;

        String nextToken = new String(buffer, workingIndex, workingTokenSize);
        
        workingIndex = getExpectedIndex(workingTokenSize);

        return nextToken;
    }

    /**
     * ���� ���ڿ����� ����� �ش��ϴ� ��ŭ �Ľ��� ���ڿ��� �����Ѵ�. 
     * 
     * @return <code>�Ľ̵� ���ڿ�</code> 
     * 
     */
    public static String getCutString(String str, int tokenSize)
    {
        byte[] buf = str.getBytes();

        if (tokenSize >= buf.length) return str;

        int size = tokenSize - CUT_POSTFIX.length();
        
        ByteUtil bt = new ByteUtil(buf, size);

        String token = bt.nextToken();
        
        if (bt.hasNext()) 
        	token = token + CUT_POSTFIX;

        return token;
    }

    private int getExpectedIndex(int workingTokenSize)
    {
        return workingIndex + workingTokenSize;
    }
}
