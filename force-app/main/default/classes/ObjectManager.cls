public class ObjectManager {
    static MockInterface mockInstance = new MockInterface();
    public static List<sObject> records(List<sObject> records){
        return mockInstance.passThrough(records);   
    }
    
    @TestVisible static void setMock(MockInterface mock){
        mockInstance = mock;
    }
}