package domain;

public class Image {
    private int id;
    private byte[] image1;
    private byte[] image2;
    private byte[] image3;
    private byte[] image4;
    private byte[] image5;
    private byte[] image6;
    private byte[] image7;
    private byte[] image8;
    private byte[] image9;
    private byte[] image10;

    // Constructor
    public Image() {
        
    }
    
    public Image(int id, byte[] image1, byte[] image2, byte[] image3, byte[] image4, byte[] image5, byte[] image6, byte[] image7, byte[] image8, byte[] image9, byte[] image10) {
        this.id = id;
        this.image1 = image1;
        this.image2 = image2;
        this.image3 = image3;
        this.image4 = image4;
        this.image5 = image5;
        this.image6 = image6;
        this.image7 = image7;
        this.image8 = image8;
        this.image9 = image9;
        this.image10 = image10;
    }

    // Getters
    public int getId() {
        return id;
    }

    public byte[] getImage1() {
        return image1;
    }

    public byte[] getImage2() {
        return image2;
    }

    public byte[] getImage3() {
        return image3;
    }

    public byte[] getImage4() {
        return image4;
    }

    public byte[] getImage5() {
        return image5;
    }

    public byte[] getImage6() {
        return image6;
    }

    public byte[] getImage7() {
        return image7;
    }

    public byte[] getImage8() {
        return image8;
    }

    public byte[] getImage9() {
        return image9;
    }

    public byte[] getImage10() {
        return image10;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setImage1(byte[] image1) {
        this.image1 = image1;
    }

    public void setImage2(byte[] image2) {
        this.image2 = image2;
    }

    public void setImage3(byte[] image3) {
        this.image3 = image3;
    }

    public void setImage4(byte[] image4) {
        this.image4 = image4;
    }

    public void setImage5(byte[] image5) {
        this.image5 = image5;
    }

    public void setImage6(byte[] image6) {
        this.image6 = image6;
    }

    public void setImage7(byte[] image7) {
        this.image7 = image7;
    }

    public void setImage8(byte[] image8) {
        this.image8 = image8;
    }

    public void setImage9(byte[] image9) {
        this.image9 = image9;
    }

    public void setImage10(byte[] image10) {
        this.image10 = image10;
    }
}
