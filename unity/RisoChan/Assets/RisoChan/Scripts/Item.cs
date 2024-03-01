using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System; 
public class Item : MonoBehaviour
{
    public static Action<Item, Item> onCollisionWithOtherItem;
    [SerializeField] private ItemType itemType;
    [SerializeField] private SpriteRenderer itemspriteRenderer;
    private bool hasCollided;
    private bool itemCanBeMerged;
    // Start is called before the first frame update
    void Start()
    {
        Invoke("AllowItemsToMerge", .25f);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void AllowItemsToMerge(){
        itemCanBeMerged = true;
    }

    public void TogglePhysics(){
        GetComponent<Rigidbody2D>().bodyType = RigidbodyType2D.Dynamic;
        GetComponent<Collider2D>().enabled = true;
    }

    public void MoveToPosition(Vector2 targetPosition){
        transform.position = targetPosition;
    }
    public Sprite GetItemSprite(){
        return itemspriteRenderer.sprite;
    }   

    public ItemType GetItemType(){
        return itemType;
    }

    public bool HasCollided(){
        return hasCollided;
    }
    
    public bool ItemCanBeMerged(){
        return itemCanBeMerged;
    }
    private  void OnCollisionEnter2D(Collision2D otherItem)
    {
        ManageOnCollisionWithOtherItem(otherItem);
    }

    private void OnCollisionStay2D(Collision2D otherItem)
    {
        ManageOnCollisionWithOtherItem(otherItem);
    }

    private void ManageOnCollisionWithOtherItem(Collision2D otherItem){
       hasCollided = true;
        if(!itemCanBeMerged){
            return;
        }
        if (otherItem.collider.TryGetComponent(out Item item))
        {   
            if (item.GetItemType() != itemType)
            {
                return;
            }

            if(!item.ItemCanBeMerged()){
                return;
            }
            
            onCollisionWithOtherItem?.Invoke(this, item);
            
        }
    }
}
