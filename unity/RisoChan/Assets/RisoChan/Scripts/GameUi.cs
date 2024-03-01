using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

[RequireComponent(typeof(ItemManager))]
public class GameUi : MonoBehaviour
{
    [SerializeField] private Image nextItemImage;
    
    private ItemManager itemManager;
    // Start is called before the first frame update

    void Awake()
    {
        itemManager = GetComponent<ItemManager>();
        ItemManager.NextItemIndexUpdated += UpdateNextItemUi;
    }

    void   OnDestroy()
    {
        ItemManager.NextItemIndexUpdated -= UpdateNextItemUi;
    }
   
    private void UpdateNextItemUi()
    {
        
        nextItemImage.sprite = itemManager.getNextItemSprite();
    }
}
