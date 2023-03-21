@isTest
public class FakeTest {
    @isTest
    public static void generateFakeData() {
        String firstName = Fake.firstName();
        System.assertNotEquals(null, firstName);

        String lastName = Fake.lastName();
        System.assertNotEquals(null, lastName);

        String companyName = Fake.companyName();
        System.assertNotEquals(null, companyName);

        String productName = Fake.productName();
        System.assertNotEquals(null, productName);
    }
}