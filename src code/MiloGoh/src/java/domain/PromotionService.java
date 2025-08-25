package domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

public class PromotionService {

    @PersistenceContext
    EntityManager em;
    @Resource
    Query query;

    public PromotionService(EntityManager em) {
        this.em = em;
    }

    public boolean addPromo(Promotion promo) {
        em.persist(promo);
        return true;
    }

    public Promotion findPromoById(int promoId) {
        Promotion promo = em.find(Promotion.class, promoId);
        return promo;
    }

    public boolean deletePromo(int promoId) {
        Promotion promo = findPromoById(promoId);
        if (promo != null) {
            em.remove(promo);
            return true;
        }
        return false;
    }

    public List<Promotion> findAll() {
        List promo = em.createNamedQuery("Promotion.findAll").getResultList();
        return promo;
    }

    public Promotion findValidPromo() {
        LocalDate localDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = localDate.format(formatter);
        Promotion promo = null;
        try{
        promo = em.createNamedQuery("Promotion.findByStatusAndDate", Promotion.class).setParameter("status", true).setParameter("validdate", formattedDate).getSingleResult();
        }catch(Exception ex){
            return promo;
        }
        return promo;
    }

    public boolean updatePromo(Promotion promo) {
        Promotion tempPromo = findPromoById(promo.getPromotionid());
        if (tempPromo != null) {
            tempPromo.setDiscount(promo.getDiscount());
            tempPromo.setStatus(promo.getStatus());
            tempPromo.setValiddate(promo.getValiddate());
            tempPromo.setDescription(promo.getDescription());
            return true;
        }
        return false;
    }
}
