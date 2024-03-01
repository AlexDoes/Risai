using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

using Random = UnityEngine.Random;

public class ItemManager : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] private Item[] itemsPrefabs;
    [SerializeField] private Item[] SpawnableItems;
    [SerializeField] private Transform ItemParentTransform;
    [SerializeField] private LineRenderer itemDropLine;
    [SerializeField] private float itemSpawnPointPos; 
    [SerializeField] private float itemSpawnDelay;
    private Item currentItem;
    private bool canControlItem;
    private bool isControllingItem;

    private int nextItemIndex;

    public static Action NextItemIndexUpdated;

    void Awake()
    {
        MergeManager.onMergeItems += onMergeItemsCallback;
    }

    void OnDestroy()
    {
        MergeManager.onMergeItems -= onMergeItemsCallback;
    }

    void Start()
    {   
        getNextItemIndex();
        canControlItem = true;
        hideitemDropLine();
    }

     
    void Update()
    {   

        if (!GameManager.instance.isMainGameState()){
            return;
        }
        if (canControlItem){
            handleInput(); 
        }
    }

    private void handleInput(){
        if(Input.GetMouseButtonDown(0)){
            HandleInputDown();
        }
        else if(Input.GetMouseButton(0)){

             if(isControllingItem){
                HandleInputDrag();
             }else{
                HandleInputDown();
             }
        }
        else if(Input.GetMouseButtonUp(0) && isControllingItem){
            HandleInputUp(); 
        }
    }

    private void getNextItemIndex(){
        nextItemIndex = Random.Range(0, SpawnableItems.Length);
        NextItemIndexUpdated?.Invoke();
    }
    public string getNextItemName(){
        return SpawnableItems[nextItemIndex].name;
    }

    public Sprite getNextItemSprite(){
        return SpawnableItems[nextItemIndex].GetItemSprite();
    }

    private void spawnItem(){
        Vector2 spawnLocation =  getitemDropLocation();
        currentItem = Instantiate(SpawnableItems[nextItemIndex],
        spawnLocation,
        Quaternion.identity,
        ItemParentTransform);
        
        getNextItemIndex();
    }


    private Vector2 getPlayerInputLocation(){
        return Camera.main.ScreenToWorldPoint(Input.mousePosition);
    }

    private Vector2 getitemDropLocation(){
        Vector2 clickedPos = getPlayerInputLocation();
        clickedPos.y = itemSpawnPointPos;
        return clickedPos;
    }
    private void HandleInputDown(){
        spawnItem();   
        showitemDropLine();
        placeLineAtClickedLocation();
        isControllingItem = true;
  
    }
    private void HandleInputDrag(){
        placeLineAtClickedLocation();
        currentItem.MoveToPosition(getitemDropLocation());
    }
    private void HandleInputUp(){
        hideitemDropLine();
        if(currentItem != null){
            currentItem.TogglePhysics();
        }
        // currentItem.TogglePhysics();
        canControlItem = false;
        isControllingItem = false;
        StartSpawnDelayTimer();


    }

    private void hideitemDropLine(){
        itemDropLine.enabled = false;
    }

    private void showitemDropLine(){
        itemDropLine.enabled = true;
    }

    private void StartSpawnDelayTimer(){
        StartCoroutine(SpawnDelay());
    }

    private IEnumerator SpawnDelay(){
        yield return new WaitForSeconds(itemSpawnDelay);
        canControlItem = true;
    }

    private void onMergeItemsCallback(ItemType itemType, Vector2 position){

        for (int i = 0; i < itemsPrefabs.Length; i++)
        {
            if (itemsPrefabs[i].GetItemType() == itemType)
            {
                SpawnMergedItem(itemsPrefabs[i], position); 
                break;
            }
            // {
            //     currentItem = Instantiate(SpawnableItems[i], position, Quaternion.identity);
            //     break;
            // }
        }
        // currentItem = Instantiate(SpawnableItems[(int)itemType], position, Quaternion.identity);
        canControlItem = true;
    }

    private void SpawnMergedItem(Item item, Vector2 position){
        // Debug.Log("Merged item type: " + item.GetItemType());
        // Debug.Log("Merged item position: " + position);
        Item MergedItem = Instantiate(item, position, Quaternion.identity, ItemParentTransform);
        MergedItem.TogglePhysics();
    }

    private void placeLineAtClickedLocation(){
        itemDropLine.SetPosition(0, getitemDropLocation());
        itemDropLine.SetPosition(1, getitemDropLocation() + Vector2.down * 15);
    }

#if UNITY_EDITOR
    private void OnDrawGizmos(){
        Gizmos.color = Color.red;
        Gizmos.DrawLine(new Vector3(-50, itemSpawnPointPos, 0), new Vector3(50, itemSpawnPointPos, 0));
    }
#endif
}
