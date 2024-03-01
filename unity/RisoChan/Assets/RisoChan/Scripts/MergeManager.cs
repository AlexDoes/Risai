using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
public class MergeManager : MonoBehaviour
{
    public static Action<ItemType, Vector2> onMergeItems;
    Item lastItem;
    void Start()
    {
        Item.onCollisionWithOtherItem += CollisonBetweenItemsCallback;
    }

    void OnDestroy()
    {
        Item.onCollisionWithOtherItem -= CollisonBetweenItemsCallback;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void CollisonBetweenItemsCallback(Item sender, Item otherItem)
    {
        if (lastItem != null)
        {
            return; 
        }

        lastItem = sender;
        MergeItems(sender, otherItem);
    }

    private void MergeItems(Item sender, Item otherItem)
    {
        // Debug.Log("Item collided with another Item" + sender.name);
  
        ItemType itemTypeMerged = sender.GetItemType();
        itemTypeMerged += 1;
        Vector2 newPositionItemMergedPosition = (sender.transform.position + otherItem.transform.position) / 2;

        //  Debug.Log("Merged item type: " + itemTypeMerged);
        //  Debug.Log("Merged item position: " + newPositionItemMergedPosition);


        Destroy(sender.gameObject);
        Destroy(otherItem.gameObject);
        // lastItem = null;
        StartCoroutine(resetLastItem());

        onMergeItems?.Invoke(itemTypeMerged, newPositionItemMergedPosition);
    }

    IEnumerator resetLastItem()
    {
        yield return new WaitForSeconds(1f);
        lastItem = null;
    }
     
}
