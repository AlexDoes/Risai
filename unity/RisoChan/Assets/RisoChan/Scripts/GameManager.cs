using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class GameManager : MonoBehaviour
{
    [SerializeField] private GameObject gameOverLine; 
    [SerializeField] private Transform ItemParentTransform;

    [SerializeField] private float gameOverDurationThreshold;

    public static GameManager instance;

    public static Action<GameState> onGameStateChanged;

    private float gameOverTimer;
    private bool timerOn;
    private bool isGameOver;

    private GameState gameState;
    
    void Awake()
    {
        if (instance == null){
            instance = this;
        }
        else{
            Destroy(gameObject);
        }
    }
    void Start()
    {
        gameState = GameState.MainGame;  
    }

   
    void Update()
    {   
        if (!isGameOver){
            HandleGameOver();
        }
        
    }

    private void HandleGameOver(){
        if (timerOn){
            HandleGamerOverTimer();
        }else{
            if (IsItemAboveLine()){
                StartTimer();
            }
        }
    }
 
    private void HandleGamerOverTimer(){
        
            gameOverTimer += Time.deltaTime;
            if (!IsItemAboveLine()){
                StopTimer();
            }

            if (gameOverTimer >= gameOverDurationThreshold){
                GameOver();
            }
        }
        
    
    private bool IsItemAboveLine(){
          for (int i = 0; i < ItemParentTransform.childCount; i++)
       {
              Item item = ItemParentTransform.GetChild(i).GetComponent<Item>();
              if (!item.HasCollided()){
                continue;
              }     
              if (IsItemAboveLine(ItemParentTransform.GetChild(i))){
                  return true;
              }
       }

       return false;
    }

    private bool IsItemAboveLine(Transform item)
    {
        if (item.position.y > gameOverLine.transform.position.y)
        {
            return true;
        }
        return false;
    }

    private void StartTimer(){
        gameOverTimer = 0;
        timerOn = true;
    }

    private void StopTimer(){
        timerOn = false;
    }

    private void GameOver(){
        Debug.Log("Game Over");
        isGameOver = true;
        SetGameOver();
    }

    public GameState GetGameState(){
        return gameState;
    }

    private void SetGameState(GameState state){
        this.gameState = state;
        onGameStateChanged?.Invoke(gameState);
    }

    private void SetGameMenu(){
        SetGameState(GameState.MainMenu);
    }

    private void SetGame(){
        SetGameState(GameState.MainGame);
    }

    private void SetGameOver(){
        SetGameState(GameState.GameOver);
    }

    public bool isGameOverState(){
        return gameState == GameState.GameOver;
    }

    public bool isMainMenuState(){
        return gameState == GameState.MainMenu;
    }

    public bool isMainGameState(){
        return gameState == GameState.MainGame;
    }

}
