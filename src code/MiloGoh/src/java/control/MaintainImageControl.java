package control;

import da.ImageDA;
import domain.Image;
import java.util.ArrayList;

public class MaintainImageControl {

    private ImageDA imageDA;

    public MaintainImageControl() {
        imageDA = new ImageDA();
    }

    public Image selectImageById(int imageId) {
        return imageDA.getImageById(imageId);
    }
    
    public ArrayList<byte[]> getAllImagesById(int imageId) {
        return imageDA.getAllImagesById(imageId);
    }

    public void addImage(Image image) {
        imageDA.addImage(image);
    }

    public void editImage(Image image) {
        imageDA.updateImage(image);
    }
    
    public void deleteImage(Image image) {
    imageDA.deleteImage(image);
}

    // You can add more methods here as needed

}
