package com.dao.model;

import java.util.HashMap;
import java.util.Map;

public class CartCreator {

    private Map<Integer, CartItem> cart;
    
    private int restaurantId; // Added to store the restaurant context

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

 

    public CartCreator() {
        this.cart = new HashMap<>();
    }

    public void addCartItem(CartItem cartItem) {
        int itemId = cartItem.getItemId();
        if (cart.containsKey(itemId)) {
            CartItem existingItem = cart.get(itemId);
            existingItem.setQuantity(existingItem.getQuantity() + cartItem.getQuantity());
            cart.put(itemId, existingItem);
        } else {
            cart.put(itemId, cartItem);
        }
    }

    public void updateCartItem(int itemId, int quantity) {
        if (quantity <= 0) {
            cart.remove(itemId);
        } else if (cart.containsKey(itemId)) {
            CartItem existingItem = cart.get(itemId);
            existingItem.setQuantity(quantity);
        }
    }


	public void removeItem(int itemId) {
        cart.remove(itemId);
    }

    public Map<Integer, CartItem> getAllItems() {
        return cart;
    }

    // Modify the clear method to reset restaurantId
    public void clear() {
        cart.clear();
        restaurantId = 0; // Reset restaurantId when clearing the cart
    }
}
